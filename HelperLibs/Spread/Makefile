BINS=test hspreadTest
LIBS=-lspread
all:	hspreadTest

libspreadhelper.so:	hspread.o
	gcc -g -shared -Wl,-soname,libspreadhelper.so -o libspreadhelper.so hspread.o -lc $(LIBS)

hspread.o:	hspread.c hspread.h
	gcc -fPIC -Wall -g -c -o hspread.o hspread.c

hspreadTest:	libspreadhelper.so hspreadTest.c
	gcc -g hspreadTest.c -o hspreadTest -L. -lspreadhelper $(LIBS)

clean:
	rm -f *.o *.so $(BINS)

install:	libspreadhelper.so
	./install.sh
