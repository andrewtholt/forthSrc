
#include "struct.h"
#include <string.h>


int main( ) {

    struct tst fred;
    memset(&fred, 0, sizeof(struct tst));

    fred.one=1;
    fred.two=2;
    fred.three=3;
    fred.four=4;
    fred.five=4;

    return 0;
}
