
all: clean NewtonCooling.fmu

mbe.c01BasicEquations.CoolingExample.NewtonCoolingWithTypes.fmu:
	omc exportFMU.mos

NewtonCooling.fmu: mbe.c01BasicEquations.CoolingExample.NewtonCoolingWithTypes.fmu

clean:
	rm -f *.fmu
	rm -f *.log
	rm -f *.libs
	rm -f *.makefile
	rm -f *.json