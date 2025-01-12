within mbe.c05PackageExamples;
model RLC "An RLC circuit referencing types from the Modelica Standard Library"
  parameter Modelica.SIunits.Voltage Vb=24 "Battery voltage";
  parameter Modelica.SIunits.Inductance L = 1;
  parameter Modelica.SIunits.Resistance R = 100;
  parameter Modelica.SIunits.Capacitance C = 1e-3;
  Modelica.SIunits.Voltage V(fixed=true, start=0);
  Modelica.SIunits.Current i_L(fixed=true, start=0);
  Modelica.SIunits.Current i_R;
  Modelica.SIunits.Current i_C;
equation
  i_R = V/R;
  i_C = C*der(V);
  i_L=i_R+i_C;
  L*der(i_L) = (Vb-V);
end RLC;
