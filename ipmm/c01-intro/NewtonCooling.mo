model NewtonCooling "An example of Newton's law of cooling"
    parameter Real T_inf "Ambient temperature";
    parameter Real T0 "Initilal temperature";
    parameter Real h "Convective cooling coefficient";
    parameter Real A "Surface Area";
    parameter Real m "Mass of thermal capacitance";
    parameter Real c_p "Specific heat";
    Real T "temperature";
initial
    T=T0;
equation
    m*c_p*der(T) = h*A*(T_inf-T) "Newton's law of cooling";
end NewtonCooling;