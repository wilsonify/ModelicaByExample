#!/usr/bin/python
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%               File name: make_OMScript.py 
#%               last modified 2011-08-12
#%               2011 - David Malo Cid
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#
# This script makes the *.mos file. The *.mos file can then be used to run a
# (Open)Modelica model as script.
#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# load modules
# --------------------------------------------------------------------------
#import sys, os, string 
# (Open) Write the OpenModelica Script file 
# --------------------------------------------------------------------------
fileObject2=open('test.mos','w',1)
fileObject2.write("loadModel(Modelica);\n")
fileObject2.write("loadFile(\"test.mo\");\n")
fileObject2.write("setComponentModifierValue(test,freq,Code(="+str(sweepVariable)+"));\n")
#Simulate and plot
# --------------------------------------------------------------------------
fileObject2.write("simulate(test, stopTime=0.00001,tolerance=0.00001,outputFormat=\"plt\");\n")
# Close OpenModelica Script file
# --------------------------------------------------------------------------
fileObject2.close()
