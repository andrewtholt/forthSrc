#!/usr/bin/python

import sys, getopt

def usage():
    print "Usage: toChar.py"
    sys.exit(0)

def process(name):
    out=""
    start=False

    with open(name) as f:
        for line in f:
            tmp=line.strip()

            if len(tmp) > 0:
                if tmp[0] == ':':
                    start=True
                    out=tmp
                elif tmp.find(';') > -1:
                    start=False
                    out=out + line
                    print '\t"' + out.strip() + '"'
                    out = ""

                elif tmp[0] == '\\':
                    pass
                if start:
                    out=out + " " + tmp

def main(argv):
    fileList=[]
    try:
        opts, args = getopt.getopt(argv,"hi:",["help","input="])
    except getopt.GetoptError:
        print 'test.py -i <inputfile> -o <outputfile>'
        sys.exit(2)

    for opt,arg in opts:
        if opt == '-h':
            usage()
        elif opt in ("-i","--input"):
            fileList.append(arg)

    print "char nvramrc[] ="
    for f in fileList:
        process( f)
    print ";"


if __name__ == "__main__":
    main(sys.argv[1:])
