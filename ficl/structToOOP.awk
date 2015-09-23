#!/usr/bin/awk -f

function outputMethod( name ) {
    printf "\t: get-%s ( 2:this )\n", name
    printf "\t\t--> .%s --> get\n",name
    printf "\t;\n"
    printf "\n"
    
    printf "\t: set-%s ( n 2:this )\n", name
    printf "\t\t--> .%s --> set\n",name
    printf "\t;\n"
    
    printf "\t: print-%s ( 2:this )\n", name
    printf "\t\t.\" %s\" 9 emit [char] : emit\n",name
    printf "\t\t--> get-%s . cr\n",name
    printf "\t;\n\n"
}
BEGIN {
    CLASS=0
    LENGTH=0
    printf "\n"
    print "only forth also oop definitions"
    printf "\n"
}

{
    HIT=0
}
/^$/ {
    HIT=1
}

/struct/ {
    if ( CLASS != 1 ) {
        NAME=$2
        printf "object subclass c-%s\n",NAME
        HIT=1
        CLASS=1
    }
}
/Boolean/ {
    if ( CLASS == 1 ) {
        LENGTH = LENGTH + 4;
        TMP=substr($2, 0, length($2)-1)
        printf "    c-4byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/char/ {
    if ( CLASS == 1 ) {
        LENGTH++
        TMP=substr($2, 0, length($2)-1)
        printf "    c-byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}


/uint8_t/ {
    if ( CLASS == 1 ) {
        LENGTH++
        TMP=substr($2, 0, length($2)-1)
        printf "    c-byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/uint16_t/ {
    if ( CLASS == 1 ) {
        LENGTH=LENGTH+2
        TMP=substr($2, 0, length($2)-1)
        printf "    c-2byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/uint32_t/ {
    if ( CLASS == 1 ) {
        LENGTH=LENGTH+4
        TMP=substr($2, 0, length($2)-1)
        printf "    c-4byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}


/int / {
    if ( CLASS == 1 ) {
        LENGTH=LENGTH+4
        TMP=substr($2, 0, length($2)-1)
        printf "    c-4byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/};/ {
    if (CLASS == 1 ) {
        printf "\n"
        for (key in list) {
            outputMethod( key )
        }
        
        printf "\t: init { 2:this }\n"
        printf "\t\tthis drop %d erase\n",LENGTH
        printf "\t\t%d this --> set-length\n",LENGTH
        printf "\t;\n\n"
        
        printf "\t: display { 2:this }\n"
        for (key in list) {
            printf"\t\tthis --> print-%s\n", key
        }
        
        printf "\t;\n\n"
        printf "end-class\n\n"
        delete list
        CLASS=0
    }
    HIT=1
}


/#include/ {
    HIT=1;
}
/#define/ {
    print $0
    HIT=1
}

/\/\/ / {
    if ( HIT != 1 ) {
        printf "\\ %s\n", $0
    }
    HIT=1
}

{
    if (HIT == 0) {
        print "\\ FIX ME " $0
    }
    HIT=0
}
