#!/usr/bin/python

import sys

verbose = True

def main():
    if len(sys.argv) > 1:
        fileName = sys.argv[1] 
    else:
        print "Usage: name <file>"
        sys.exit(0)
    
    file = open( fileName,'r')

    for line in file:
        words = line.split()

        l=""
        for token in words:

            try:
                n = int(token)
            except ValueError:
                if token == "{" or token == "}":
                    l= l +  token
                elif token == "high":
                    l = l + "H"
                elif token == "low":
                    l = l + "L"
                elif token == "delay":
                    l = l +"D"
                elif token == "true":
                    l=l+"T"
                elif token=="while":
                    l=l+"w"
                elif token=="output":
                    l=l+"O"
            else:
                l= l +  token


        if verbose:
            print l
        else:
            sys.stdout.write( l )
    print




main()
