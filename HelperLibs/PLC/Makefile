
BINS=test

all:	test

libplc.so:	plc.o
	gcc -g -shared -Wl,-soname,libplc.so -o libplc.so plc.o -lc

plc.o:	plc.c plc.h
	gcc -fPIC -Wall -g -c -o plc.o plc.c

test:	libplc.so test.c
	gcc -g test.c -o test -L. -lplc

clean:
	rm -f *.o *.so $(BINS)

install:	libplc.so
	./install.sh
