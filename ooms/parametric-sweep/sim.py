#!/usr/bin/python
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%               File name: sim.py 
#%               last modified 2011-08-12
#%               2011 - David Malo Cid
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#
# The script extract data from simulation result.
#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# load modules
# --------------------------------------------------------------------------
#import sys, os 
# Function to create a vector of zeros.
# --------------------------------------------------------------------------
def zeros(n):
	vec = [0.0]
	for i in range(int(n)-1):  
		vec = vec + [0.0]
	return vec
# Open OpenModelica result file for reading
# --------------------------------------------------------------------------
fileObject5=open("test_res.plt",'r',1)
# Read simulation interval size
# --------------------------------------------------------------------------
line = fileObject5.readline() 
size = int(fileObject5.readline().split('=')[1])
#print size
time = zeros(size)
source_vAC_mag_dB = zeros(size)
while line != ['DataSet: time\n']:
	line = fileObject5.readline().split(',')[0:1]
for j in range(int(size)):
	time[j] = float(fileObject5.readline().split(',')[0]) #[0:2]
while line != ['DataSet: nmostransistor1.source_vAC_mag_dB\n']:
	line = fileObject5.readline().split(',')[0:1]	
for j in range(int(size)):
	source_vAC_mag_dB[j] =float(fileObject5.readline().split(',')[1]) 
# Close OpenModelica result file
# --------------------------------------------------------------------------
fileObject5.close()
# Open simulation output file for writing 
# --------------------------------------------------------------------------
fileObject26=open('ParametricSweep.plt','a+',1)
# --------------------------------------------------------------------------
fileObject26.write(str(sweepVariable)+ ", " + str(source_vAC_mag_dB[1]) + "\n")
fileObject26.close()
