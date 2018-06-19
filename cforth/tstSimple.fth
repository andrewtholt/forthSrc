fl simpleSpread.fth

s" cforth" set-user
s" raspberrypi0" set-server

1024 buffer: rx-msg

: err-report ( rc -- )
    0< if
        sp-error
        abort
    then
;

: status-report ( rc -- rc )
    dup err-report
;
    
sp-dump

sp-connect err-report 

s" global" sp-join err-report 

s" hello" s" global" sp-tx err-report 
1024 rx-msg sp-rx status-report

rx-msg swap type cr
.s

