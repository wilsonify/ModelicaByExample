within ModelicaByExample.Functions.Polynomials;
function Polynomial "Create a generic polynomial from coefficients"
  input Real x     "Independent variable";
  input Real c[:]  "Polynomial coefficients";
  output Real y    "Computed polynomial value";
protected
  Integer n = size(c,1);
algorithm
  y := c[1];
  for i in 2:n loop
    y := y*x + c[i];
  end for;
end Polynomial;
