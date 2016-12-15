
set -e AMFORTH
set -e AMFORTH_LIB
set -e AMFORTH_ROOT_LIB

set -x AMFORTH /home/andrewh/Source/Forth/My-amforth-6.1
set AMFORTH_ROOT_LIB $AMFORTH/avr8/lib
# set AMFORTH_COMMON_LIB $AMFORTH/common/lib

set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_ROOT_LIB"
# set -x AMFORTH_LIB "$AMFORTH/common/lib:$AMFORTH_ROOT_LIB"
# 
# set -x AMFORTH_LIB $AMFORTH_ROOT_LIB
# 
# set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_COMMON_LIB"
# 
# set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_COMMON_LIB/forth2012"
# set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_COMMON_LIB/forth2012/tools"
set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_ROOT_LIB/forth2012/core"
set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH_ROOT_LIB/forth2012/core-ext"
# set -x AMFORTH_LIB "$AMFORTH_LIB:$AMFORTH/appl/myArduino/blocks"
# 
# echo $AMFORTH_COMMON_LIB/forth2012/core    
# 
set -x AMFORTH_LIB "$AMFORTH_LIB:."