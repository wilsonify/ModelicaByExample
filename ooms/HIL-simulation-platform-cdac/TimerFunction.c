/* C file TimerFunction.c for getting Realtime */

#include "windows.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>

LARGE_INTEGER InitialTime;
LARGE_INTEGER Frequency;
LARGE_INTEGER CurrentTime;



double getRealTime(double tm)
{	
	
	QueryPerformanceCounter(&CurrentTime);
    QueryPerformanceFrequency(&Frequency);
	return ((double)(CurrentTime.QuadPart-InitialTime.QuadPart)/Frequency.QuadPart);
	
}


double initTime(double tn)
{
	
	QueryPerformanceCounter(&InitialTime);
    
	return((double)(InitialTime.QuadPart));
	
}


