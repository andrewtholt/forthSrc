\ cforth

-1 value libutils

s" libutils.so" 1 dlopen to libutils

libutils 0= abort" Can't find libutils.so"

s" test"       libutils dlsym abort" Not found" acall: test { i.a i.b i.c -- i.sum }
s" testString" libutils dlsym abort" Not found" acall: test-str { $.t -- }

