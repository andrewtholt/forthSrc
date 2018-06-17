#include "sp.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>

#include "hspread.h"


__attribute__ ((__constructor__)) void preFunc(void) {
    strcpy(spreadSetting.user,"helper");
    spreadSetting.port = 4803;
    strcpy(spreadSetting.host,"localhost");
    
    sprintf(spreadSetting.server,"%d@%s", spreadSetting.port, spreadSetting.host);
    
    sprintf(spreadSetting.iam,"#%s#%s", spreadSetting.user,spreadSetting.host);
}

void setUser(char *u) {
    strncpy(spreadSetting.user,u, MAX_USER_LEN);
    sprintf(spreadSetting.iam,"#%s#%s", spreadSetting.user,spreadSetting.host);
}

char *getUser() {
    char *ret = spreadSetting.user;
    
    return ret;
}

char *getIam() {
    char *ret = spreadSetting.iam;
    
    return ret;
}

void setPort(int p) {
    spreadSetting.port = 4803;
    sprintf(spreadSetting.server,"%d@%s", spreadSetting.port, spreadSetting.host);
}

void setServer(char *s) {
    strncpy(spreadSetting.host,s, HOST_NAME_MAX);
    sprintf(spreadSetting.server,"%d@%s", spreadSetting.port, spreadSetting.host);
    sprintf(spreadSetting.iam,"#%s#%s", spreadSetting.user,spreadSetting.host);
}

char *getServer(void) {
    char *ret = spreadSetting.server;
    
    return ret;
}

int SPConnectSimple() {
    int ret;
    
    ret=SP_connect(spreadSetting.server, spreadSetting.user, 0, 1, &spreadSetting.Mbox, spreadSetting.Private_group);
    
    return ret;
}

int SPJoinSimple(char *group) {
    int ret=-1;
    
    ret=SP_join(spreadSetting.Mbox, group);
    
    return ret;
}

int SPLeaveSimple(char *group) {
    int ret=-1;
    
    ret=SP_leave(spreadSetting.Mbox, group);
    
    return ret;
}

int SPRxSimple( char *message, int len) {
    int ret=-1;
    int service_type=0;
    int num_groups;
    int16 mess_type;
    int endian_mismatch;
    
    char localMsg[MAX_MESSLEN];
    
    char sender[MAX_GROUP_NAME];
    char targetGroups[MAX_GROUPS][MAX_GROUP_NAME];
    
    bool exitFlag=false;
    do {
        bzero(localMsg,MAX_MESSLEN);
        ret = SP_receive(spreadSetting.Mbox, &service_type, sender, MAX_GROUPS, &num_groups,
                         targetGroups, &mess_type, &endian_mismatch, MAX_MESSLEN, localMsg);
        
        if(Is_regular_mess(service_type)) {
            if(sender[0] == '#' ) {
                if(strcmp(sender, spreadSetting.iam) !=0) {
                    strncpy(message,localMsg, len);
                    exitFlag=true;
                }
            }
        }
    } while(!exitFlag);
    return ret;
}

int SPTxSimple(char *group, char *msg) {
    int ret=-1;
    
    ret = SP_multicast( spreadSetting.Mbox, AGREED_MESS, group, 1, strlen(msg), msg );
    
    return ret;
}

int SPPollSimple() {
    int ret=-1;
    
    ret = SP_poll( spreadSetting.Mbox);
    
    return ret;
}
