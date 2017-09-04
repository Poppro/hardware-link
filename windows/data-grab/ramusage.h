#pragma once
#include<windows.h>
#include <iostream>

#define DIV 1048576

class Ramusage {
private:
public:
	DWORDLONG currentuse();
};