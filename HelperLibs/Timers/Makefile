
CPP=g++ -std=c++11
CFLAGS=-g -fPIC
LIBS=-lficl
INCS=-I/usr/local/include
BINS= lib # ficlTest tst

MAJOR=1
MINOR=0

all:	$(BINS) libficltimer.so.$(MAJOR).$(MINOR) lib

lib:	libficltimer.so.$(MAJOR).$(MINOR)


ficlTimer.o:	ficlTimer.cpp ficlTimer.h
	$(CPP) -c $(CFLAGS) $(INCS) ficlTimer.cpp -o ficlTimer.o

ficlTest:	ficlTimer.o ficlTest.cpp
	$(CPP) $(CFLAGS) $(INCS) ficlTest.cpp ficlTimer.o -o ficlTest -lnewtimers

tst:	ficlTimer.o tst.c
	$(CC) $(CFLAGS) $(INCS) tst.c ficlTimer.o -o tst $(LIBS) -lficltimer -lnewtimers -lstdc++ -ldl

libficltimer.so.$(MAJOR).$(MINOR):	ficlTimer.o
		gcc -g -shared -Wl,-soname,libficltimer.so.$(MAJOR).$(MINOR) -o libficltimer.so.$(MAJOR).$(MINOR) ficlTimer.o -lnewtimers -lficl -lc -lstdc++ 

install:
	./install.sh

clean:
	rm -f $(BINS)
	rm -f *.o cscope.out lib*

