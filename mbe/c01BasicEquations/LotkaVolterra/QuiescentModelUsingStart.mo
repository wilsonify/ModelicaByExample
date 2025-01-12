within mbe.c01BasicEquations.LotkaVolterra;
model QuiescentModelUsingStart "Find steady state solutions to LotkaVolterra equations"
  parameter Real alpha=0.1 "Reproduction rate of prey";
  parameter Real beta=0.02 "Mortality rate of predator per prey";
  parameter Real gamma=0.4 "Mortality rate of predator";
  parameter Real delta=0.02 "Reproduction rate of predator per prey";
  Real x(start=10) "Prey population";
  Real y(start=10) "Predator population";
initial equation
  der(x) = 0;
  der(y) = 0;
equation
  der(x) = x*(alpha-beta*y);
  der(y) = y*(delta*x-gamma);
end QuiescentModelUsingStart;
