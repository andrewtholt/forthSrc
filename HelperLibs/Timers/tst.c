#include "ficlTimer.h"


int main() {
    struct timerMaster *boss;
    
    boss = newTimerMaster();

    int idx = addTimer(boss,15);

    display(boss);
}

