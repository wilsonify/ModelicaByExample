model NewtonCoolingWithTypes "An example of Newton's law of cooling"
    // Types
    type Temperature=Real(unit="",min=0);
    type ConvectionCoefficient=Real(unit="W/(m2.K)",min=0);
    type Area=Real(unit="m2",min=0);
    type Mass=Real(unit="kg",min=0);
    type SpecificHeat=Real(unit="J/(K.kg)",min=0);
    
    // Parameters
    parameter Temperature T_inf=298.15 "Ambient temperature";
    parameter Temperature T0=363.15 "Initilal temperature";
    parameter ConvectionCoefficient h=0.7 "Convective cooling coefficient";
    parameter Area A=1.0 "Surface Area";
    parameter Mass m=0.1. "Mass of thermal capacitance";
    parameter SpecificHeat c_p=1.2 "Specific heat";

    // Variables
    Real T(unit="K") "temperature";
initial
    T=T0;
equation
    m*c_p*der(T) = h*A*(T_inf-T) "Newton's law of cooling";
end NewtonCoolingWithTypes;