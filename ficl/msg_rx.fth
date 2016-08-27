load struct.fth
\ load mydump.fth

struct
2 chars field cmd
4 chars field address
endstruct /cmd

-1 value command
-1 value qid

/cmd allocate abort" record alloc" to command

22 openqueue abort" openqueue" to qid

command qid 0 msg-recv abort" msg-recv"

command /cmd dump cr cr

command cmd type cr


