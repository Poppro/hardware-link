#pragma once
#include <iostream>
#include <tchar.h>
#include <windows.h>

class Diskspace {
private:
	ULARGE_INTEGER liFreeBytesAvailable;
	ULARGE_INTEGER liTotalNumberOfBytes;
	ULARGE_INTEGER liTotalNumberOfFreeBytes;

	const LONGLONG nKBFactor = 1024;
	const LONGLONG nMBFactor = nKBFactor * 1024;
	const LONGLONG nGBFactor = nMBFactor * 1024; 
public:
	double getFreeSpaceC();
	double getFreeSpaceE();
};