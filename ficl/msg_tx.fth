load struct.fth
\ load mydump.fth

\ struct message {
\    uint8_t address;  // defaults to 0
\    uint8_t cmd[2];
\    uint8_t item;
\    uint8_t v_lo;
\    uint8_t v_hi;
\ };

struct 
1 chars field address
2 chars field cmd
1 chars field item
1 chars field v_lo
1 chars field v_hi
endstruct /cmd

0 value initRun
-1 value command
43 value qid
-1 value ptr

: init
    initRun 0= if
        /cmd allocate abort" record alloc" to command
        255 allocate abort" allocate" to ptr
        qid openqueue abort" openqueue" to qid
    then
;

init

s" SM" command cmd swap move
0 command address c!
13 command item c!
 1 command v_lo c!
 0 command v_hi c!
\ 
\ \ s" 0001" command address drop swap move
\ 
command 16 dump
\ 
\ 
command /cmd  qid msg-send abort" msg-send"
\ 
\ s" WD" command cmd swap move
\ 0 command address c!
\ 13 command item c!
\  1 command v_lo c!
\  0 command v_hi c!
\ 
\ command /cmd  qid msg-send abort" msg-send"

