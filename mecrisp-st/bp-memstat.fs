\ bp-memstat.fs
\ For use with Mecrisp-Stellaris Forth by Matthias Koch
\ Used with a Blue Pill (STM32F103C8T6)
\ Copyright 2019  t.porter <terry@tjporter.com.au>, licensed under the GPL
\ This Program:  prints out memory stats

 compiletoflash
\ compiletoram

: flashfree 
   compiletoram? 
   $1FFFF7E0 @ $FFFF and 1024 *
   compiletoflash
   here -
   swap
      if compiletoram
   then
;

: ramfree    
   compiletoram?
   not
   flashvar-here
   4 -
   compiletoram
   here -
   swap
      if compiletoflash	
   then
;

: free ( -- ) ." (bytes) " cr
   ." FLASH.. TOTAL REPORTED: " $1FFFF7E0 @ $FFFF and 1024 * dup >R .
   ." USED: " R> flashfree  - u. ." FREE: " flashfree .
   cr
   20000 >R								\ RAM VALUE, <--- CHANGE for your chip.
   ." RAM.... TOTAL PRESET: "  R@ u. ." USED: " R> ramfree - u. ." FREE: " ramfree .
   cr cr
 ;

compiletoram



