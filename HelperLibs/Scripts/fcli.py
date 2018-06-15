#!/usr/bin/python3

import atexit
import time

import readline
import io
import os
import sys
import getopt
import _thread

import select

import pexpect


def usage():
    print("Usage: cli.py -f|--file <file path> -h|--help -v|--verbose -b|--baud <rate> -t|--tty <tty> -p|--prompt <prompt>")
    print()
    print("\t-h|--help\tHelp.")
    print("\t-f <fn>|----file=<fn>\tLoad fcli commands from file.")
    print("\t-v|--verbose\tVerbose.")
    print("\t-p|--prompt\tSet prompt")


    print("\nNotes:")
    print("\tTo exit type <ctrl>d")
    print("\tFor local commands help enter ^help.")
    print()

def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)


def make_completer(vocabulary):
    def custom_complete(text, state):
        # None is returned for the end of the completion session.
        results = [x for x in vocabulary if x.startswith(text)] + [None]
        # A space is added to the completion since the Python readline doesn't
        # do this on its own. When a word is fully completed we want to mimic
        # the default readline library behavior of adding a space after it.
        return results[state] + " "
    return custom_complete

def cmdHelp():
    print("Command help")
    print("^save\tSave current history.")
    print("^ficl\tInteractions with ficl, for more info tun ^ficl help")

def ficlHelp():
    print("Ficl Help")
    print("\t^ficl start <file name>\tStart a new instance.")
    print("\t\t\t\tIf a file is specified this is passed to the new instance\n")
    print("\t^ficl select <n>\tSelect instance n.")
    print("\t^ficl list\t\tPrint number of running instances.")

def main():
    verbose = False
    prompt = "OK "
    fileName=None

    count=0;
    macros = {}

    inst = []

    p=None

    try:
        opts, args = getopt.getopt(sys.argv[1:],"f:vhp:",["file=","verbose","help","prompt="])
    except getopt.GetoptError as err:
        print("Unknown option")
        usage()
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            sys.exit()
        elif o in ("-v","--verbose"):
            verbose=True;
            print("Verbose")
        elif o in ("-p","--prompt"):
            prompt=a;
        elif o in ("-f","--file"):
            fileName = a;

    histfile = os.path.join(os.path.expanduser("~"), ".fcli_history")

    try:
        readline.read_history_file(histfile)
        h_len = readline.get_current_history_length()
    except FileNotFoundError:
        open(histfile, 'wb').close()
        h_len = 0

    vocabulary = {'words', '.s'}
    readline.parse_and_bind('tab: complete')
    readline.set_completer(make_completer(vocabulary))

    readList = [sys.stdin]
    s=""
    send=" "

    cmdFile = None

    if fileName != None:
        if verbose:
            print("Load commands from " + fileName )
        try:
            cmdFile = open(fileName,'r')
            opos = 0
        except FileNotFoundError:
            print("No such file")
            cmdFile = None

    try:
        while True:
            out=""

            if cmdFile != None:
                s = cmdFile.readline()
                pos = cmdFile.tell()
                if pos == opos:
                    cmdFile.close
                    cmdFile = None
                else:
                    opos = pos
                    s=s.strip()
            else:
                s = input(prompt).strip()

            if len(s) > 0:
                localCmd = s.split()
                cmd = localCmd[0]

                if cmd == "?" :
                    usage()
                elif cmd[0] == '^':
                    if cmd == "^ficl":
                        if len(localCmd) == 1:
                            ficlHelp()
                        else:
                            if localCmd[1] == "help":
                                ficlHelp()
                            elif localCmd[1] == "start":
                                if len(localCmd) > 2:
                                    cmd = 'ficl -f ' + localCmd[2]
                                else:
                                    cmd = 'ficl'

                                x = pexpect.spawnu(cmd)
                                inst.append(x)
                                print(count)
                                count = count+1
                            elif localCmd[1] == "select":
                                print("Instance " + localCmd[2] + " selected")
                                item = int(localCmd[2])

                                prompt = "OK %d:" % item

                                try:
                                    p=inst[ item ]
                                except:
                                    print("No such instance")

                            elif localCmd[1] == "list":
                                l=len(inst)
                                print("%d programes running" % l)

                    elif cmd == "^echo":
                        out=""
                        for n in localCmd[1:]:
                            out = out + n + " "
                        print(out)
                    elif cmd == "^save":
                        print("Save History")
                        readline.set_history_length(1000)
                        readline.write_history_file(histfile)
                    elif cmd == "^help":
                        cmdHelp()
                    elif cmd == "^macro":
                        if len(localCmd) == 1:
                            print("Macro Help")
                        else:
                            if localCmd[1] == 'add':
                                print('Add Macro')
                                macroName = input("Name   : ")
                                content =   input("Content: ")

                                macros[macroName]= content
                            elif localCmd[1] == 'list':
                                for mn, mc in macros.items():
                                    print("Name   : " + mn )
                                    print("Content: " + mc )
                            elif localCmd[1] == 'save':
                                print('Save')
                                macroFileName = (input("Filename: ") or "./tst.m")
                                print("Save to " + macroFileName)
                                try:
                                    f = open(macroFileName, 'w')
                                    for mn, mc in macros.items():
                                        f.write(mn + ":" + mc )
                                    f.close()
                                except:
                                    print("Ooops")
                            elif localCmd[1] == 'load':
                                macroFileName = (input("Filename: ") or "./tst.m")
                                print("Loading from "+ macroFileName)
                                try:
                                    f = open(macroFileName, 'r')
                                    for line in f:
                                        tmp=line.split(':')
                                        macros[tmp[0]] = tmp[1]
                                except:
                                    print("Ooops")

                    else:
                        mn = cmd[1:]
                        print(mn)

                        if mn in macros:
                            print("Found")
                            s = macros[ mn ]
                        else:
                            print("Don't understand " + s)

                if s[0] != '^':
                    send = (s.encode('ascii','ignore'))
    
                    if p == None:
                        print("No instance selected")
                    else:
                        p.sendline( send.decode("utf-8"))
                        runFlag = True
                        while runFlag :
                            try:
                                p.expect('ok> ',timeout=0.1)
                                print(p.before)
                            except:
                                runFlag=False
    
                        print(p.before)


    except (EOFError, KeyboardInterrupt) as e:

        print('\nShutting down...')
        readline.set_history_length(1000)
        readline.write_history_file(histfile)


if __name__ == '__main__':
    main()
