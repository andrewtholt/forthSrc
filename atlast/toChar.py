#!/usr/bin/python

import sys, getopt

def usage():
    print "Usage: toChar.py -i file ... -i file -o outfile"

    print "\tConvert a list of files into an array of strings."
    print 'NOTE: Embedded quotes are not dealt with.'
    sys.exit(0)

def process(name):
    out=""
    rvalue=""

    start=False

    rvalue=rvalue +  "// " + name + "\n"
    with open(name) as f:
        for line in f:
            tmp=line.strip()
#            l=t.replace('"', '\\"')

            if len(tmp) > 0:
                if tmp[0] == ':':
                    start=True
                    out=tmp
                elif tmp.find(';') > -1:
                    start=False
                    out=out + line
                    rvalue=rvalue + '\t"' + out.strip() + '"\n'

                elif tmp[0] == '\\':
                    pass
                if start:
                    out=out + " " + tmp
    return rvalue

def main(argv):
    fileList=[]
    output="/dev/tty"

    try:
        opts, args = getopt.getopt(argv,"hi:o:",["help","input=","output="])
    except getopt.GetoptError:
        print 'test.py -i <inputfile> -o <outputfile>'
        sys.exit(2)

    for opt,arg in opts:
        if opt == '-h':
            usage()
        elif opt in ("-i","--input"):
            fileList.append(arg)
        elif opt in ("-o","--output"):
            output=arg

    out = open( output,"w")
    out.write( "char nvramrc[] =")
    for f in fileList:
        l=process( f)
        out.write( l)
    out.write( ";\n")
    out.close()


if __name__ == "__main__":
    main(sys.argv[1:])
