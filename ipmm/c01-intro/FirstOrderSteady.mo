model FirstOrderSteady
    "First order equation with steady state initial condition"
    Real x "State variable"
initial equation
    der(x)=0; "initial value"
equation
    der(x) = 1-x "drives x toward 1.0";
end FirstOrderSteady;