load struct.fth
\ load mydump.fth

\ struct message {
\    uint8_t address;  // defaults to 0
\    uint8_t cmd[2];
\    uint8_t item;
\    uint8_t v_lo;
\    uint8_t v_hi;
\ };


0 value initRun
-1 value command
-1 value qid
-1 value ptr

: init
    initRun 0= if
        255 allocate abort" allocate" to ptr
        22 openqueue abort" openqueue" to qid
    then
;

init

s" FORTH" qid msg-send abort" msg-send"
\ 
\ s" WD" command cmd swap move
\ 0 command address c!
\ 13 command item c!
\  1 command v_lo c!
\  0 command v_hi c!
\ 
\ command /cmd  qid msg-send abort" msg-send"

