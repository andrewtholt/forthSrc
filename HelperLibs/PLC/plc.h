
#pragma once

#include <stdbool.h>
#include <stdint.h>

bool plcAnd(bool a, bool b);
bool plcOr(bool a, bool b);
bool plcNot(bool a);

bool plcTimer(bool start, int32_t interval);

