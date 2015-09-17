#!/usr/bin/awk -f

function outputMethod( name ) {
    printf "\t: get-%s ( 2:this )\n", name
    printf "\t\t--> .%s --> get\n",name
    printf "\t;\n\n"
}
BEGIN {
    CLASS=0
    printf "' \\ alias \/\/\n\n"
    print "only forth also oop definitions"
}

{
    HIT=0
}
/^$/ {
    HIT=1
}
/struct/ {
    NAME=$2
    printf "object subclass c-%s\n",NAME
    HIT=1
    CLASS=1
}
/Boolean/ {
    if ( CLASS == 1 ) {
        TMP=substr($2, 0, length($2)-1)
        printf "    c-4byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/char/ {
    if ( CLASS == 1 ) {
        TMP=substr($2, 0, length($2)-1)
        printf "    c-byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}


/uint8_t/ {
    if ( CLASS == 1 ) {
        TMP=substr($2, 0, length($2)-1)
        printf "    c-byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/uint16_t/ {
    if ( CLASS == 1 ) {
        TMP=substr($2, 0, length($2)-1)
        printf "    c-2byte obj: .%s\n",TMP
        list[TMP]=1
    }
    HIT=1
}

/int / {
    if ( CLASS == 1 ) {
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
        printf "end-class\n\n"
        delete list
        CLASS=0
    }
    HIT=1
}
/\/\/ / {
    if ( HIT != 1 ) {
        print "\\ ", $0
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

{
    if (HIT == 0) {
        print "\\ FIX ME " $0
    }
    HIT=0
}
