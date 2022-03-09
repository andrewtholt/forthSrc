\ memstat.fs
\ For use with Mecrisp-Stellaris Forth by Matthias Koch, Version: 2.3.6
\ Used with a STM32F051 MCU
\ Author:  T.Porter <terry@tjporter.com.au> 2017
\ This Program:  prints out memory stats
\ Screenpic
\ ...........................................
\ mem (bytes) 
\ FLASH.. TOTAL: 65472 USED 23648 FREE: 41824 
\ RAM.. FREE: 6636
\ ...........................................
compiletoflash

: flashfree compiletoram? $10000 compiletoflash here - swap if compiletoram then ; 
: ramfree compiletoram? not flashvar-here compiletoram here - swap if compiletoflash then ;
: free ." (bytes) " cr
." FLASH.. TOTAL: " $1FFFF7CC @ abs dup . ." USED: " flashfree dup >r - . ." FREE: " r> . cr ." RAM.... FREE: " ramfree .
\ cr depth ." Stack Depth: " . cr
cr cr ;

compiletoram
