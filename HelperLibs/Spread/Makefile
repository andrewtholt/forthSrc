BINS=test
LIBS=-lspread
all:	test

libspreadhelper.so:	hspread.o
	gcc -g -shared -Wl,-soname,libspreadhelper.so -o libspreadhelper.so hspread.o -lc $(LIBS)

hspread.o:	hspread.c hspread.h
	gcc -fPIC -Wall -g -c -o hspread.o hspread.c

test:	libspreadhelper.so test.c
	gcc -g test.c -o test -L. -lspreadhelper $(LIBS)

clean:
	rm -f *.o *.so $(BINS)

install:	libspreadhelper.so
	./install.sh
