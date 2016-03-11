#!/usr/bin/python

def tst(align, length):
    padding = (align - (length % align)) % align
    return padding

def tst1(width, addr ):
    r = width * (( addr/width ) +1 )
    return r


def main():

    data = [ 1,2,1,4 ];
    res = [ 0,2,4,8 ];
    idx = 0;

    offset = 0;
    ptr = 0
    r = 0

    for n in data:
        print n,ptr
        print "n=",n
        print "r=",r
        r = tst1(n,ptr)

        print tst(4,n)
        print "-----"
        ptr +=r



main()
