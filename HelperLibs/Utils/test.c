#include <stdio.h>
#include <string.h>
#include "utils.h"


int main() {
    char path[1024];
    int rc=-1;

    strcpy(path,"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin") ;

    char buffer[255];

    rc = expandPath(path, "als", buffer);
    printf("als rc=%d\n", rc);
    if( rc == 0) {
        printf("%s\n", buffer);
    }

    rc = expandPath(path, "ls", buffer);
    printf("ls rc=%d\n", rc);
    if( rc == 0) {
        printf("%s\n", buffer);
    }
    
    memDump(path,128);

    printf("Terminal IO\n");

    printf("Press a key .\n");


    rc=0;
    do {
        rc=athQkey();
    } while(rc == 0);

    char k;

    k= athGetKey();

    printf("And the key was %c\n", k);

    memset(path,0,sizeof(path));

    strncpy(path,"Head:",5);

    rc=strCat(path,5,"tail",4);
    printf("rc=%d\n", rc);
    printf("headr>%s<\n", path);

}

