
load dynamic.fth
load utils.fth

-1 value libbatch
-1 value libelcofs

-1 value data
-1 value header
-1 value master

\ int expandPath(char *dirList, char *fileName, char *buffer);


s" /usr/local/lib/libbatch.so" dlopen abort" failed" to libbatch
s" libElcoFS.so" dlopen abort" failed" to libelcofs

0 0 s" lsof" libelcofs dlsym abort" Not found" mkfunc lsof
\ 
\ Master class methods
\ 
1 0 s" newBatchMaster"    libbatch dlsym abort" Not found" mkfunc new-batch-master
\ openBatch: master batch_idx -- batch_inst
1 2 s" openBatch"         libbatch dlsym abort" Not found" mkfunc open-batch
1 2 s" closeBatch"        libbatch dlsym abort" Not found" mkfunc close-batch
1 1 s" displayMaster"     libbatch dlsym abort" Not found" mkfunc display-master
1 2 s" addBatch"          libbatch dlsym abort" Not found" mkfunc add-batch
\ 
\ end

1 1 s" newBatch"          libbatch dlsym abort" Not Found" mkfunc new-batch
0 2 s" setBatchName"      libbatch dlsym abort" Not Found" mkfunc set-batch-name
0 2 s" setBatchSize"      libbatch dlsym abort" Not Found" mkfunc set-batch-size
1 1 s" getBatchSize"      libbatch dlsym abort" Not Found" mkfunc get-batch-size
1 1 s" getReferenceCount" libbatch dlsym abort" Not Found" mkfunc get-reference-count

0 1 s" flushHeader"     libbatch dlsym abort" Not Found" mkfunc flush-header
0 1 s" flushFile"       libbatch dlsym abort" Not Found" mkfunc file-flush
1 0 s" getReadingSize"  libbatch dlsym abort" Not Found" mkfunc reading-size
1 0 s" getHeaderSize"   libbatch dlsym abort" Not Found" mkfunc header-size
1 2 s" setDeleteTag"    libbatch dlsym abort" Not Found" mkfunc set-delete-tag

0 2 s" setRdg20"    libbatch dlsym abort" Not Found" mkfunc set-reading-20
0 2 s" setRdg60"    libbatch dlsym abort" Not Found" mkfunc set-reading-60
0 2 s" setDateTime" libbatch dlsym abort" Not Found" mkfunc set-date-time

1 2 s" getRdg20"      libbatch dlsym abort" Not Found" mkfunc get-reading-20
1 2 s" getRdg60"      libbatch dlsym abort" Not Found" mkfunc get-reading-60
1 2 s" getDateTime"   libbatch dlsym abort" Not Found" mkfunc get-date-time

0 1 s" displayRecord" libbatch dlsym abort" Not Found" mkfunc display-reading
0 1 s" displayHeader" libbatch dlsym abort" Not Found" mkfunc display-header

\ getReading: inst idx data
1 3 s" getReading"      libbatch dlsym abort" Not Found" mkfunc get-reading
\ getFirstReading: inst data ignoreTag
1 2 s" getFirstReading" libbatch dlsym abort" Not Found" mkfunc get-first-reading
\ getLastReading: inst data ignoreTag
1 2 s" getLastReading"  libbatch dlsym abort" Not Found" mkfunc get-last-reading

\ getNextReading: inst idx ignoreTag
1 3 s" getNextReading"  libbatch dlsym abort" Not Found" mkfunc get-next-reading  

\ getPrevReading: inst idx ignoreTag
1 3 s" getPrevReading"  libbatch dlsym abort" Not Found" mkfunc get-prev-reading  

\ seekToReading inst start pos ignoreTag
1 4 s" seekToReading"   libbatch dlsym abort" Not Found" mkfunc seek-to-reading
\ addReading: inst data
1 2 s" addReading"      libbatch dlsym abort" Not Found" mkfunc add-reading
\ rmReading: inst
0 1 s" rmReading"       libbatch dlsym abort" Not Found" mkfunc rm-reading

0 1 s" rmBatchEntries"  libbatch dlsym abort" Not Found" mkfunc rm-all-readings

1 1 s" getReadingCount" libbatch dlsym abort" Not Found" mkfunc get-reading-count

\ 
\ 1024 mk-buffer drop value location
\ 1024 mk-buffer drop value path-list


\ : test
\     path-list s" PATH" getenv
\ 
\     drop s" ls" drop location expand-path
\ 
\ ;

reading-size allocate abort" Allocation Failed" to data
data reading-size erase

header-size allocate abort" Allocation Failed" to header
header header-size erase

-1 value test1

new-batch-master to master

\ 1 new-batch to test1
\ test1 1 set-delete-tag
\ 
\ test1 s" Forth" drop set-batch-name
\ 

: add-batches ( n --- ) 
    1 do 
        .s
        i . cr
        master i add-batch drop
        master i close-batch abort" Failed to close batch"
\         100 ms

    loop
;
: mk-reading ( n --- )
    data reading-size erase

    dup 0x1020 + data swap set-reading-20
        0x1060 + data swap set-reading-60
    data display-reading
;

: add-readings ( n -- )
    0 do 
        test1
        i mk-reading 
        data add-reading
    loop
    test1 flush-header
;

: add-tagged-readings ( n -- )
    0 do 
        test1
        i mk-reading 
        data add-reading

        test1 rm-reading
    loop
    test1 flush-header
;

: dump-readings { | idx -- }

    test1 get-first-reading 
\     test1 data 1 get-first-reading dup 0= abort" First reading failed" to idx
\ 
\     data display-reading
\ 
\     begin
\         test1 idx 1 get-next-reading dup to idx
\         ." Index " idx . cr 
\     while
\         test1 idx data get-reading data display-reading
\     repeat

;

