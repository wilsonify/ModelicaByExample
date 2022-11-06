model FirstOrderDocumented "A simplge first order differential equation"
    Real x "State variable";
initial equation
    x=2 "Used before simulation to compute initial value";
equation
    der(x) = 1-x "Drives value of x toward 1.0";
end FirstOrderDocumented;