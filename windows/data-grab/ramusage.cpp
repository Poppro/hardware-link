#include "ramusage.h"

DWORDLONG Ramusage::currentuse() {
	MEMORYSTATUSEX statex;

	statex.dwLength = sizeof(statex);

	GlobalMemoryStatusEx(&statex);

	return 16384 - (statex.ullAvailPhys / DIV);
}