model NewtonCoolingWithDefaults "An example of Newton's law of cooling"
    parameter Real T_inf=25 "Ambient temperature";
    parameter Real T0=90 "Initilal temperature";
    parameter Real h=0.7 "Convective cooling coefficient";
    parameter Real A=1.0 "Surface Area";
    parameter Real m=0.1. "Mass of thermal capacitance";
    parameter Real c_p=1.2 "Specific heat";
    Real T "temperature";
initial
    T=T0;
equation
    m*c_p*der(T) = h*A*(T_inf-T) "Newton's law of cooling";
end NewtonCoolingWithDefaults;