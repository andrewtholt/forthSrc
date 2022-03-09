
#include <stdbool.h>
#ifdef __cplusplus
#include "timerMaster.h"

extern "C" {
#endif
    struct timerMaster *newTimerMaster();

    int addTimer(struct timerMaster *boss, int interval);
    bool startTimer(struct timerMaster *boss, int idx);
    bool stopTimer(struct timerMaster *boss, int idx);
    bool resetTimer(struct timerMaster *boss, int idx);
    int nextTimer(struct timerMaster *boss);
    void oneShot(struct timerMaster *boss, int idx, bool n);
    void updateTimers(struct timerMaster *boss, int interval);

//    void setCallback(struct timerMaster *boss, int idx, void (*callBack)(void **p));
    void setCallback(struct timerMaster *boss, int idx);
    void setCallbackParameters(struct timerMaster *boss, int idx, void *vm, void *xt);
    
    void display(struct timerMaster *boss);
#ifdef __cplusplus
}
#endif

