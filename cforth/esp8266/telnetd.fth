\ telnetd

: wifi-on  ( -- )
   2 wifi-opmode!   \ AP mode
   .ssid  space  ipaddr@ .ipaddr
;

#0 constant ERR_OK              \ No error, everything OK.
#-1 constant ERR_MEM            \ Out of memory error.
#-2 constant ERR_BUF            \ Buffer error.
#-3 constant ERR_TIMEOUT        \ Timeout.
#-4 constant ERR_RTE            \ Routing problem.
#-5 constant ERR_INPROGRESS     \ Operation in progress
#-6 constant ERR_VAL            \ Illegal value.

\ Above errors are fatal, below ones are not

#-7 constant ERR_WOULDBLOCK     \ Operation would block.
#-8 constant ERR_ABRT           \ Connection aborted.
#-9 constant ERR_RST            \ Connection reset.
#-10 constant ERR_CLSD          \ Connection closed.
#-11 constant ERR_CONN          \ Not connected.
#-12 constant ERR_ARG           \ Illegal argument.
#-13 constant ERR_USE           \ Address in use.
#-14 constant ERR_IF            \ Low-level netif error
#-15 constant ERR_ISCONN        \ Already connected.

create inet-addr-any  0 l,
create inet-addr-none  $ffffffff l,

\ pbuf  is  next.l, bufp.l, totlen.w, thislen.w, type.b, flags.b, refcnt.w, ptr.l

: close-connection  ( pcb -- )
   0 0 2 pick tcp-poll  ( pcb )
   0 over tcp-err   ( pcb )
   0 over tcp-recv  ( pcb )
   0 over tcp-sent  ( pcb )
   tcp-close        ( err )
   \ err could be ERR_MEM if there was insufficient memory to do the
   \ close, in which case we are supposed to retry later via either a
   \ poll callback or a sent callback.  For now we ignore that case.
   drop             ( )
;

: pbuf>len  ( pbuf -- adr thislen totlen )
   >r                (             r: pbuf )
   r@ la1+ l@        ( adr         r: pbuf )
   r@ 2 la+ wa1+ w@  ( adr thislen r: pbuf )
   r> 2 la+ w@       ( adr thislen totlen )
;



vocabulary telnetd-v
also telnetd-v definitions

warning off

0 value telnetd-pcb
0 value telnetd-listen-pcb

: tcp-write-bare  ( adr len -- )
   telnetd-pcb tcp-write drop
;

: evaluate-throw  ( adr len -- )
   evaluate  -98 throw
;

: commander  ( adr len -- )
   ['] tcp-write-bare to reply-send
   reply{  ['] evaluate-throw  catch  drop 2drop  prompt  }reply
;

: receiver  ( err pbuf pcb arg -- err )
   drop  to telnetd-pcb  nip    ( pbuf )
   ?dup 0=  if                  ( )
      telnetd-pcb close-connection
      ERR_OK exit               ( -- err )
   then                         ( pbuf )
   dup pbuf>len                 ( pbuf adr len totlen )
   telnetd-pcb tcp-recved       ( pbuf adr len )
   rot >r                       ( adr len r: pbuf )  \ hide my stack
   commander                    ( r: pbuf )
   r>                           ( pbuf )
   pbuf-free drop               ( )
   ERR_OK                       ( err )
;

: accepter  ( err new-pcb arg -- err )
   drop >r                     ( err r: new-pcb )
   ?dup  if                    ( err r: new-pcb )
      r> drop                  ( err )
      drop                     ( )
      ERR_ABRT
      exit
   then                        ( )
   telnetd-listen-pcb tcp-accepted
   ['] receiver r@ tcp-recv
   r@ to telnetd-pcb
   r> drop
   ['] tcp-write-bare to reply-send
   reply{  banner prompt  }reply
   ERR_OK                      ( err )
;

: telnetd-off  ( -- )
   telnetd-listen-pcb  ?dup  if  tcp-close drop  0 to telnetd-listen-pcb  then
;

: telnetd-on  ( -- )
   telnetd-off
   tcp-new    ( pcb )
   #23 inet-addr-any  2 pick  tcp-bind  abort" Bind failed"  ( pcb )
   1 swap tcp-listen-backlog  to telnetd-listen-pcb
   ['] accepter telnetd-listen-pcb tcp-accept   ( )
;

previous definitions  also telnetd-v

: telnetd  telnetd-on  ;
: telnetd-off  telnetd-off  ;

previous
