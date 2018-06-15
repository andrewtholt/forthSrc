#include "ficlTimer.h"
#include <stdint.h>

char *printBool(bool v) {
    if(v) {
        return((char *)" TRUE ");
    } else {
        return((char *)" TRUE ");
    }
}

void fred(void **p) {
    printf("============\n");
    printf("Callback run\n");
    printf("p[0]=%d\n",(int64_t)p[0]);
    printf("p[1]=%d\n",(int64_t)p[1]);
    printf("============\n");
}

int main() {

    int delay=10;
    int idx=-1;
    bool flag;
    int v=0;

    void *vm;
    void *xt;

    timerMaster *tst;

    tst = newTimerMaster();

    idx = addTimer(tst, delay);

    flag = startTimer(tst,idx);

    printf("Set callback\n");

    setCallback(tst,idx);
    vm = (void *)4;
    xt = (void *)5;
    
    setCallbackParameters(tst,idx,vm,xt);

    printf("Start Timer returned:%s \n\n", printBool(flag));

    display(tst);

    updateTimers(tst, 2);

    printf("Updated timers\n");

    display(tst);

    printf("Reset  timer\n");

    flag = resetTimer(tst, idx);

    printf("\tReturned %s\n", printBool(flag));

    display(tst);


    flag = stopTimer(tst,idx);

    printf("Stop Timer returned :%s \n\n", printBool(flag));

    display(tst);

    printf("Restarted timer, and updateTimer\n");
    flag = startTimer(tst,idx);

    for(int i=0;i< 6;i++) {
        updateTimers(tst, 2);

        printf("Next Timer\n");
        v=nextTimer(tst);
        printf("\tReturned %d\n", v);
        display(tst);
    }
    /*

       tst = new ficlTimer(delay);

*/
}

