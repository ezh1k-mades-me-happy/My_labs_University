#define WIN32_LEAN_AND_MEAN
#include <windows.h>

void WINAPI entry(void)
{
    DWORD written;
    WriteFile(GetStdHandle(STD_OUTPUT_HANDLE),
              "Hello World!", 12, &written, NULL);
    ExitProcess(0);
}