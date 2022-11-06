model NewtonCoolingWithUnits "An example of Newton's law of cooling"
    parameter Real T_inf(units="K")=25 "Ambient temperature";
    parameter Real T0(units="K")=90 "Initilal temperature";
    parameter Real h(units="W/(m2.K)")=0.7 "Convective cooling coefficient";
    parameter Real A(units="m2")=1.0 "Surface Area";
    parameter Real m(units="kg")=0.1. "Mass of thermal capacitance";
    parameter Real c_p(units="J/(K.kg)")=1.2 "Specific heat";
    Real T(unit="K") "temperature";
initial
    T=T0;
equation
    m*c_p*der(T) = h*A*(T_inf-T) "Newton's law of cooling";
end NewtonCoolingWithUnits;