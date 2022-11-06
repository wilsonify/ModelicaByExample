/* file: ModelicaPrint.c-write a value into file */
#include <stdio.h>
double ModelicaPrint(const char *fileName,double x)

{
FILE *fp;

if ( ( fp = fopen (fileName,"w+" )) == NULL )
{
printf ( "\nUnable to open file" ) ;
return (-1);

}
fprintf(fp,"%lf \n",x);
fclose(fp);
return x;
}
