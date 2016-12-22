#!/usr/bin/awk -f

BEGIN {
        RS=":"
        IDX=0

        printf("static char nvramrc[] =\n")
}

{
    split($0,n,";")
    gsub("\n"," ",n[1])
    gsub(/[  ]+/," ",n[1])

    tmp=n[2]

    gsub(/[  ]+/,"",tmp)

    print index(tmp,"immediate")
    if( index(tmp,"immediate") == 1 ) {
        print " immediate"
    } 

    if (length(n[1]) >0 ) {
        printf "\t\":%s ;\"\n",n[1]
    }
}

END {
    print ";\n"
}
