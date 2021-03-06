
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

load lib.fth
load struct.fth

struct 
    uint8_t field state
    uint32_t field STM1Sent
    uint32_t field STM4Sent
    uint32_t field STM9Sent
    
    
    uint32_t field STM1Received
endstruct /STM

-1 value fd
0 value initRun
-1 value ptr

-1 value semid

: init
    initRun 0= if
        s" /STMState" O_RDWR 0x1ff shm-open abort" shm-open failed."
        to fd

        fd 0 53 mmap abort" mmap failed" to ptr

        s" /STMStateLock" O_RDWR 0x1ff 1 sem-create abort" sem-open failed." 
        to semid

        -1 to initRun
    then
;

: .semvalue ( semid -- )
    sem-getvalue abort" sem-getvalue failed."
    ." sem-getvalue : " . cr
;

: main
    init

    semid .semvalue
    semid sem-wait abort" sem-wait failed."
    ptr 53 dump
    semid sem-post abort" sem-post failed."

;
