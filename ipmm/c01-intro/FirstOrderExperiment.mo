model FirstOrder
    Real x;
initial equation
    x=2;
equation
    der(x) = 1-x "drives x toward 1.0";
    annotation(experiment(StartTime=0,StopTime=8));
end FirstOrder;