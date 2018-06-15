#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <termios.h>
#include <sys/select.h>

#include "utils.h"

#define EMPTY '\0'
#define NB_DISABLE 1
#define NB_ENABLE 0

static int ttyfd = 0;   /* STDIN_FILENO is 0 by default */
struct termios orig_termios;
static char cbuf = EMPTY;

void fatal(char *message) {
    fprintf(stderr, "fatal error: %s\n", message);
    exit(1);
}

static void tty_raw(void) {
    struct termios  raw; 
    int i;

//    extern struct termios orig_termios; /* TERMinal I/O Structure */

    i = tcgetattr( ttyfd, &orig_termios);
    i = tcgetattr( ttyfd, &raw);
//    raw = orig_termios; /* copy original and then modify below */

    /*   
     * input modes - clear indicated ones giving: no break, no CR to NL,
     * no parity check, no strip char, no start/stop output (sic) control
     */
    raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);

    /*   
     * output modes - clear giving: no post processing such as NL to
     * CR+NL
     */
    raw.c_oflag &= ~(OPOST);

    /* control modes - set 8 bit chars */
    raw.c_cflag |= (CS8);

    /*   
     * local modes - clear giving: echoing off, canonical off (no erase
     * with backspace, ^U,...),  no extended functions, no signal chars
     * (^Z,^C)
     */
    raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);

    /*
     * control chars - set return condition: min number of bytes and
     * timer
     */
    //    raw.c_cc[VMIN] = 5;
    //    raw.c_cc[VTIME] = 8;    /* after 5 bytes or .8 seconds after first byte seen      */
    //    raw.c_cc[VMIN] = 0;
    //    raw.c_cc[VTIME] = 0;    /* immediate - anything       */
    //    raw.c_cc[VMIN] = 2;
    //    raw.c_cc[VTIME] = 0;    /* after two bytes, no timer  */
    //    raw.c_cc[VMIN] = 0;
    //    raw.c_cc[VTIME] = 8;    /* after a byte or .8 seconds */

    /* put terminal in raw mode after flushing */
    if (tcsetattr(ttyfd, TCSAFLUSH, &raw) < 0)
        fatal("can't set raw mode");
}

static int tty_reset(void) {
//    extern struct termios orig_termios; /* TERMinal I/O Structure */

    /* flush and reset */
    if (tcsetattr(ttyfd, TCSAFLUSH, &orig_termios) < 0) { 
        return -1;
    }    
    return 0;
}

static void nonblock(int state) {
    struct termios ttystate;

    //get the terminal state
    tcgetattr(STDIN_FILENO, &ttystate);

    if (state==NB_ENABLE)     {    
        //turn off canonical mode
        ttystate.c_lflag &= ~ICANON;
        //minimum of number input read.
        ttystate.c_cc[VMIN] = 1; 
    } else if (state==NB_DISABLE) {
        //turn on canonical mode
        ttystate.c_lflag |= ICANON;
    }    
    //set the terminal attributes.
    tcsetattr(STDIN_FILENO, TCSANOW, &ttystate);

}

static int kbhit() {
    struct timeval  tv;  
    fd_set          fds;
    tv.tv_sec = 0; 
    tv.tv_usec = 0; 
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds);
    //STDIN_FILENO is 0
    select(STDIN_FILENO + 1, &fds, NULL, NULL, &tv);
    return FD_ISSET(STDIN_FILENO, &fds);
}

bool athQkey() {

    tty_raw();
    nonblock(0);
    bool keyHit=false;

    if(kbhit() !=0 ) {
        cbuf=fgetc(stdin);
        keyHit = true;
    } else {
        cbuf = EMPTY;
        keyHit = false;
    }
    tty_reset();
    nonblock(1);
    
    return keyHit;

}

char athGetKey() {

    int i;
    extern struct termios orig_termios; /* TERMinal I/O Structure */
    char c;

    i = tcgetattr( ttyfd, &orig_termios);

    if( cbuf != EMPTY ) {
//        ficlStackPushInteger(vm->dataStack, cbuf);
        c = cbuf;
        cbuf = EMPTY ;
    } else {
        tty_raw();
        nonblock(0);
        i=fgetc(stdin);
        nonblock(1);
        tty_reset();
//        ficlStackPushInteger(vm->dataStack, i);
        c = (char)i;
    }
    return c;
}

char keystroke(int t) {
    static char     buf[10];
    static int      total, next;
    //    struct sgttyb   ns;

    if (next >= total)     {
        switch (total = read(0, buf, sizeof(buf)))         {
            case -1:
                fatal("System call failure: read\n");
                break;
            case 0:
                fatal("Mysterious EOF\n");
                break;
            default:
                next = 0;
                break;
        }
    }
    return (buf[next++]);
}

int expandPath(char *dirList, char *fileName, char *buffer) {
    int rc = -1;

    char *ptr=NULL;

    char tmpSpace[4096];

    int len=strlen(dirList);

    if( len == 0) {
        return rc;
    }

    char scratch[len];

    strcpy(scratch, dirList); 

    ptr = strtok( scratch, ":");

    do {
        strcpy(tmpSpace, ptr);
        strcat(tmpSpace,"/");
        strcat(tmpSpace,fileName);

        if ( access(tmpSpace, F_OK) == 0) {
            strcpy(buffer,tmpSpace);
            rc = 0;
            ptr = NULL;
        } else {
            ptr = strtok( NULL, ":");
        }
    } while(ptr != NULL);

    return rc;
}

static void displayLineHex(uint8_t *a) {
    int i;

    for(i=0;i<16;i++) {
        /*
           sprintf(outBuffer," %02x",*(a++));
           printf("%s",outBuffer);
           */
        printf(" %02x",*(a++));
    }    
}

static void displayLineAscii(uint8_t *a) {
    int i;

    printf(":");

    for(i=0;i<16;i++) {
        if( (*a < 0x20 ) || (*a > 0x80 )) {
            printf(".");
            a++;
        } else {
            printf("%c",*(a++));
        }
    }
    printf("\r\n");
}

void memDump(uint8_t *address, int length) {
    int lines=length/16;

    if(lines ==0 ) {
        lines=1;
    }
    printf("\r\n");

    int i=0;
    for( i = 0; i<length;i+=16) {
        /*
        sprintf(outBuffer,"%08x:", (uintptr_t)address);
        printf("%s", outBuffer);
        */
        printf("%08x:", address);

        displayLineHex( address );
        displayLineAscii( address );
        address +=16;
    }
}

bool strToBool( char *msg ) {
    bool res=false;
    res = (bool)(strncmp(msg,"YES",3) == 0) || (strncmp(msg,"ON",2)) == 0 || (strncmp(msg,"TRUE",4) == 0);

    return res;
}

// Joins the forth string tail to the end of head.
// Head must have sufficient space for the new string.
//
uint32_t strCat( char *head, uint32_t hLen, char *tail, uint32_t tLen) {
    char *dest=NULL;

    dest = head + hLen;
    strncpy(dest, tail, tLen);

    return(hLen+tLen);
}

void strCpy( char *to, char *from, uint32_t fLen) {
    strncpy(to,from,fLen);
}

int test(int a, int b, int c) {
    int sum = a+b+c;

    printf("a=%d\n",a);
    printf("b=%d\n",b);
    printf("c=%d\n",c);
    printf("sum=%d\n",sum);

    return sum;
}



