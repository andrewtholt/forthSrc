
: value    constant ;

: value!   >body ! ;

\ : to       state @ if
\                [compile] ['] [compile] value!
\            else
\                ' value!
\            then ; immediate
\ 
\ 
\ 
