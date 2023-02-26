within mbe.c04Functions.ImpureFunctions;
impure function computeHeat "Modelica wrapper for an embedded C controller"
  input Real T;
  input Real Tbar;
  input Real Q;
  output Real heat;
  external "C" annotation (Include="#include \"ComputeHeat.c\"",
    IncludeDirectory="modelica://mbe.c04Functions.ImpureFunctions/source");
end computeHeat;
