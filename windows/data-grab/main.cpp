#include <iostream>
#include <fstream>
#include <windows.h>
#include "cpuload.h"
#include "ramusage.h"
#include "diskspace.h"

using namespace std;

void print() {
	Cpuload c;
	Ramusage r;
	Diskspace d;
	ofstream out_data("data.json");
	out_data << "{" << endl;
	out_data << "  \"dataset\": [" << endl;
	out_data << "  {" << endl;
	out_data << "  \"cpu\": \"" << c.GetCPULoad() << "\"," << endl;
	out_data << "  \"ram\": \"" << r.currentuse() << "\"," << endl;
	out_data << "  \"HDD\": \"" << d.getFreeSpaceE() << "\"," << endl;
	out_data << "  \"SSD\": \"" << d.getFreeSpaceC() << "\"" << endl;
	out_data << "  }" << endl;
	out_data << "  ]" << endl;
	out_data << "}" << endl;
}

int main()
{
	FreeConsole();
	while (true) {
		print();
		Sleep(2000);
	}

	return 0;
}
