[IFDEF] my-code
   my-code
[ENDIF]
marker my-code

require unix/pthread.fs

1000 newtask constant bg1
1000 newtask constant bg2

variable counter1
variable counter2

: (task1)
    begin
        1 counter1 +!
        pause 
    again
;

: (task2)
    begin
        1 counter2 +!
        pause 
    again 
;

: start-task1 bg1 activate (task1) ;
: start-task2 bg2 activate (task2) ;

: show counter1 ? ."    " counter2 ? ;

: start 
    start-task1
    start-task2

    show
;

