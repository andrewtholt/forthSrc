#include "cpp.h"
int main() {

    void *n=NULL;

    char tst[] = "testing 1 2 3";

    struct myVector *p = newVector();

    printf("Vector:Size is %d\n", vectorSize(p));

    vectorAppend(p,n);
    printf("Vector:Size is %d\n", vectorSize(p));

    vectorAppend(p,n);
    vectorAppend(p,n);
    vectorAppend(p,n);

    printf("Vector:Size is %d\n", vectorSize(p));

    vectorErase(p,0);
    printf("Vector:Size is %d\n", vectorSize(p));

    vectorEraseAll(p);
    printf("Vector:Size is %d\n", vectorSize(p));

    struct myMap *m = newMap();
    printf("Map:Size is %d\n", mapSize(m));

    mapAdd(m,"Test", tst);
    printf("Map:Size is %d\n", mapSize(m));

    char *res = mapGet(m,"Test");

    printf("Map:Get entry 'Test', result is >%s<\n", res);

    bool rc = mapExists(m,"Test");

    printf("Map:Entry 'Test' exists, result is >%d<\n", rc);

    printf("Map:Erase All\n");
    mapEraseAll(  m);

    printf("Map:Size is %d\n", mapSize(m));

    mapAdd(m,"Testing 1",(void *)1);
    mapAdd(m,"Testing 2",(void *)2);
    mapAdd(m,"Testing 3",(void *)3);

    printf("Map:Erase 'Testing'\n");
    printf("Map:Before Size is %d\n", mapSize(m));
    mapErase( m, "Testing 2");
    printf("Map:After  Size is %d\n", mapSize(m));

}
