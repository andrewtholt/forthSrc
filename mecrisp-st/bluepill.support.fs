\ support.fs
\ For use with Mecrisp-Stellaris Forth by Matthias Koch
\ Used with a Blue Pill (STM32F103C8T6)
\ Copyright 2019  t.porter <terry@tjporter.com.au>, licensed under the GPL
\ This program: Useful LED (PC-13) config Wordsa

compiletoflash

: RCC_APB2ENR_ADC1EN   %1 9 lshift RCC_APB2ENR bis! ;	    \ RCC_APB2ENR_ADC1EN    ADC 1 interface clock  enable

: RCC_APB2ENR_ADC1-DIS   %1 9 lshift RCC_APB2ENR bic! ; 

: ADC1EN?   %1 9 lshift RCC_APB2ENR bit@
   if ." ADC1 is ENABLED "
      else ." ADC1 is DISABLED "
   then cr
; 

: GPIOC_CRH_MODE13   ( %XX -- ) 20 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE13

: GPIOC_CRH_MODE13-clear   ( %XX -- ) 20 lshift GPIOC_CRH bic! ;

: GPIOC_CRH_CNF13   ( %XX -- ) 22 lshift GPIOC_CRH bis! ;   \ GPIOC_CRH_CNF13

: GPIOC_CRH_CNF13-clear   ( %XX -- ) 22 lshift GPIOC_CRH bic! ;

: GPIOC_BSRR_BS13   %1 13 lshift GPIOC_BSRR bis! ;	    \ GPIOC_BSRR_BS13    Set bit 13

: GPIOC_BSRR_BR13   %1 29 lshift GPIOC_BSRR bis! ;	    \ GPIOC_BSRR_BR13    Reset bit 13

: GPIOC_13_clear ( -- )		 \ Clear all GPIOC_13 config bits
   %11 20 lshift GPIOC_CRH bic!	 \ GPIOC_CRH_MODE13  0,0
   %11 22 lshift GPIOC_CRH bic!	 \ GPIOC_CRH_CNF13   0,0
;

: pc13.high ( -- ) GPIOC_BSRR_BS13 ;
: pc13.low  ( -- ) GPIOC_BSRR_BR13 ;

: GPIOC_13_output ( -- )	 \ Output, Push-Pull: MODE13:1,0   CNF13:0,0
   GPIOC_13_clear		 \ MODE13:0.0  CNF13:0,0 
   %10 20 lshift GPIOC_CRH bis!	 \ MODE13:1,0  SET PC13 as PUSH-PULL
   pc13.high			 \ Start with LED off
;

: ledon pc13.low ;   \ The Blue Pill obviously has the LED anode connected to +3.3v and the Cathode to PC13
		     \ (plus a resistor somewhere). When PC13 is HIGH the LED is OFF.
		     \ This means PC13 could be in "open collector mode" instead of "push-pull"and work fine also.
: ledoff pc13.high ;

compiletoram
