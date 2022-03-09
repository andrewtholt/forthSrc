
#include "ficlTimer.h"
#include "ficl.h"

extern "C" {

    void ficlTimerCallback(void *fred[]) {
        ficlVm *vm;
        char *cmd;

        printf("===============\n");
        printf("Callback called\n");
        printf("===============\n");

        printf("vm %0x\n", fred[0]);
        printf("cmd %s\n", fred[1]);

        vm = (ficlVm *) fred[0];
        cmd = (char *)fred[1];


//        ficlStackPushPointer(vm->dataStack,xt);
//        ficlVmExecuteWord(vm,xt);
        ficlVmEvaluate(vm,cmd);
    }

    struct timerMaster *newTimerMaster() {
        struct timerMaster *boss;

        boss = new timerMaster();

        return boss;
    }

    int addTimer(struct timerMaster *boss, int interval) {
        int idx=-1;

        idx = boss->addTimer(interval);

        return idx;
    }

    bool startTimer(struct timerMaster *boss, int idx) {
        bool flag=true;

        flag=boss->startTimer(idx);

        return flag;
    }

    bool stopTimer(struct timerMaster *boss, int idx) {
        bool flag=true;

        flag=boss->stopTimer(idx);

        return flag;
    }

    bool resetTimer(struct timerMaster *boss, int idx) {
        bool flag=true;

        flag=boss->resetTimer(idx);

        return flag;
    }

    int nextTimer(struct timerMaster *boss) {
        int n;

        n = boss->nextTimer();
        return n;
    }

    void oneShot(struct timerMaster *boss, int idx, bool n) {
        boss->oneShot(idx, n);
    }

    void updateTimers(struct timerMaster *boss, int interval) {
        boss->updateTimers(interval);
    }

//    void setCallback(struct timerMaster *boss, int idx, void (*callback)(void **p)) {
    void setCallback(struct timerMaster *boss, int idx) {
        (void)boss->stopTimer(idx);
        boss->setCallback(idx, ficlTimerCallback);
    }
    
    void setCallbackParameters(struct timerMaster *boss, int idx, void *vm, void *xt){
        void *p[2];

        p[0] = vm;
        p[1] = xt ;
        boss->setCallbackParameters(idx, p);
        
    }

    void display(struct timerMaster *boss) {

        boss->display();
    }
}

