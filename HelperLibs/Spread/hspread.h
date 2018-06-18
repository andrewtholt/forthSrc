#include "sp.h"
#include <limits.h>
#define MAX_MESSLEN     1024
#define MAX_GROUPS 10
#define MAX_USER_LEN 32


struct {
    int Mbox;
    char user[MAX_USER_LEN];
    int port;
    char host[HOST_NAME_MAX];
    // 8 is the max lengh of a port number rendered as a string + seperator and NULL
    //
    char server[HOST_NAME_MAX + 8 ]; 

    char Private_group[MAX_GROUP_NAME];
    
    char iam[MAX_USER_LEN+HOST_NAME_MAX+4];
} spreadSetting;

char *getUser();
void setUser(char *u);

char *getIam();

char *getServer(void) ;
void setServer(char *s) ;

int SPConnectSimple();

int SPJoinSimple(char *group);
int SPLeaveSimple(char *group);

int SPRxSimple( char *msg, int len) ;
int SPTxSimple(char *group, char *msg);
int SPPollSimple();

void dump();
