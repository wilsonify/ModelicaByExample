/* file:ModelicaRead.c -to read a value from a file*/

#include <stdio.h>

double ModelicaRead(char *fileName,double tm)
{
    FILE *fpi;
    double y;
	
if ( ( fpi = fopen (fileName,"r" )) == NULL )

{

printf ( "\nUnable to open file" ) ;

return(-1) ;

}
		
fscanf(fpi, "%lf", &y);
fclose(fpi);

 return (y);
}