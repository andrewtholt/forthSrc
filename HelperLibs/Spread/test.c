#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


#include "hspread.h"

void dumpSettings() {
	printf("User    :%s\n",getUser());
	printf("Server  :%s\n",getServer());
	printf("\n");
}

int main() {
	int rc=0;
    
    char rxMsg[255];

	dumpSettings();

	setUser("tester");
	setServer("raspberrypi0");
	dumpSettings();

	rc=SPConnectSimple();

	printf("SPConnectSimple rc=%d\n", rc);
    
    if(rc<0) {
        exit(1);
    }
    
    rc=SPJoinSimple("global");
	printf("SPJoinSimple rc=%d\n", rc);
    
    rc =  SPTxSimple("global", "Hello from tester") ;
	printf("SPTxSimple rc=%d\n", rc);
    
    sleep(1);
    rc = SPPollSimple();
    printf("SPPollSimple rc = %d\n", rc);
    
	printf("Calling SPRxSimple\n");
    rc= SPRxSimple( rxMsg, 255) ;
	printf("SPRxSimple rc =%d\n", rc);
	printf("           msg=>%s<\n", rxMsg);
    
    rc=SPLeaveSimple("global");
    
    sleep(1);
}
