#include "diskspace.h"

double Diskspace::getFreeSpaceC() {
	GetDiskFreeSpaceEx(_T("c:\\"), &liFreeBytesAvailable, &liTotalNumberOfBytes, &liTotalNumberOfFreeBytes);
	return (double)(LONGLONG)liTotalNumberOfFreeBytes.QuadPart / nMBFactor;
}
double Diskspace::getFreeSpaceE() {
	GetDiskFreeSpaceEx(_T("E:\\"), &liFreeBytesAvailable, &liTotalNumberOfBytes, &liTotalNumberOfFreeBytes);
	return (double)(LONGLONG)liTotalNumberOfFreeBytes.QuadPart / nMBFactor;
}