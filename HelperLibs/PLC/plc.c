
#include "plc.h"

bool plcAnd(bool a, bool b) {
    bool res=false;

    res = a & b;

    return res;
}

bool plcOr(bool a, bool b) {
    bool res=false;

    res = a | b;

    return res;
}

bool plcNot(bool a) {
    bool res = false;

    res = (a) ? false : true ;
    return res;
}

bool plcTimer(bool start, int32_t interval) {

    bool res=false;

    if( start ) {
    }

    return res;
}


