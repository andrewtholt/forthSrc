BINS=test

all:	test

libutils.so:	utils.o
	gcc -g -shared -Wl,-soname,libutils.so -o libutils.so utils.o -lc

utils.o:	utils.c utils.h
	gcc -fPIC -Wall -g -c -o utils.o utils.c

test:	libutils.so test.c
	gcc -g test.c -o test -L. -lutils

clean:
	rm -f *.o *.so $(BINS)

install:	libutils.so
	./install.sh
