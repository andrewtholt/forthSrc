fl simpleSpread.fth

s" cforth" set-user
s" raspberrypi0" set-server

1024 buffer: rx-msg

: err-report ( rc -- rc )
    dup 0< if
        sp-error
        abort
    then
;
    
sp-dump

sp-connect err-report drop

\ s" global" sp-join err-report

s" hello" s" global" sp-tx err-report drop
1024 rx-msg sp-rx err-report

rx-msg swap type cr
.s

