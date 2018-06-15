
s" dynamic.fth" sfind nip 0= [if]
    .( loading dynamic.fth ... ) cr
    load dynamic.fth
    .( ... done ) cr
[then]

-1 value libtimers


s" libficltimer.so" dlopen abort" failed" to libtimers

1 0 s" newTimerMaster"        libtimers dlsym abort" Not Found" mkfunc new-timer-master
1 2 s" addTimer"              libtimers dlsym abort" Not Found" mkfunc add-timer
1 2 s" startTimer"            libtimers dlsym abort" Not Found" mkfunc start-timer
1 2 s" stopTimer"             libtimers dlsym abort" Not Found" mkfunc stop-timer
1 2 s" resetTimer"            libtimers dlsym abort" Not Found" mkfunc reset-timer
1 3 s" oneShot"               libtimers dlsym abort" Not Found" mkfunc one-shot

1 2 s" updateTimers"          libtimers dlsym abort" Not Found" mkfunc update-timers
0 2 s" setCallback"           libtimers dlsym abort" Not Found" mkfunc set-callback
0 4 s" setCallbackParameters" libtimers dlsym abort" Not Found" mkfunc set-callback-parameters

0 1 s" display"        libtimers dlsym abort" Not Found" mkfunc timer-display
