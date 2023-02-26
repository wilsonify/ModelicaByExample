within mbe.c01BasicEquations.SimpleExample;
model FirstOrder
  Real x;
equation
  der(x) = 1-x;
end FirstOrder;
