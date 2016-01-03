#!/usr/bin/awk -f

BEGIN {
    print "\\ "
    print "load lib.fth"
    print "\\ "
}
{
    HIT=0
}
/^$/ {
    HIT=1
}
/struct/ {
    NAME=$2
    print "struct"
    HIT=1
}
/Boolean/ {
    TMP=substr($2, 0, length($2)-1)
    printf "    uint32_t field %s\n",TMP
    HIT=1
}

/char/ {
    TMP=substr($2, 0, length($2)-1)
    printf "    uint8_t field %s\n",TMP
    HIT=1
}


/uint8_t/ {
    TMP=substr($2, 0, length($2)-1)
    printf "    uint8_t field %s\n",TMP
    HIT=1
}

/};/ {
    printf "endstruct /%s\n",NAME
    HIT=1
}
/#define / {
    HIT=1
    print $0
}
{
    if (HIT == 0) {
        print "\\ FIX ME " $0
    }
    HIT=0
}
