
\ User LD2: the green LED is a user LED connected to Arduino signal D13 corresponding to
\ MCU I/O PA5 (pin 21) or PB13 (pin 34) depending on the STM32 target.
\ On the Nucleo 401RE, this is PA5.

\ B1 USER: the user button is connected to the I/O PC13 (pin 2) of the STM32
\ microcontroller.


: button? ( -- ? )  1 13 lshift PORTC_IDR bit@ not ;
: led     ( ? -- )  if 1 5 lshift porta_bsrr ! else 1 5 lshift 16 lshift porta_bsrr ! then ;

: blinky ( -- )
 
  %01 5 2* lshift porta_moder bis!  \ Set LED Pin mode to output

  begin
    button? if    true led  500000 0 do loop false led  500000 0 do loop
            else  true led 1000000 0 do loop false led 1000000 0 do loop
            then
  key? until
;
