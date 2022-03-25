showstack

: iam " logger_tst" ;

: log-file$ c" /var/tmp/%s.txt" ;

-1 value fd-out
0 value log-init-run?

#255 constant /env-buffer

/env-buffer buffer: env-buffer
/env-buffer buffer: log_file


: log-init
    log-init-run? 0= if
        s" LOG_FILE" env-buffer getenv ?dup 0= if
            iam log-file$ count sprintf log_file place
        else
            env-buffer swap log_file place
        then
            
        log_file count r/w create-file abort" Open failed"  to fd-out
    then
;

: write-log ( $.addr -- )

    log-init

    log{
        s" %s\n" printf
    }log

    log$ fd-out write-file abort" Write"

\     fd-out close-file abort" Close."

;
