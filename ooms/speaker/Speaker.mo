model Speaker
 
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=27.8, freqHz=20) ;
  Modelica.Electrical.Analog.Basic.Resistor Re(R=6.3) ;
  Modelica.Electrical.Analog.Basic.Inductor Le(L=0.000158) ;
    
  Modelica.Electrical.Analog.Basic.Inductor Le_prim(L=1e-6) ;
   
  Modelica.Electrical.Analog.Basic.Ground Ground1 ;
    
  Modelica.Electrical.Analog.Basic.Inductor Le_comp(L=0.0028) ;
    
  Modelica.Electrical.Analog.Basic.Resistor Rdamp(R=0.75) ;
    
  Modelica.Electrical.Analog.Basic.Capacitor Cmass(C=0.000954) ;
    
  Modelica.Electrical.Analog.Basic.Capacitor Crad(C=0.000156) ;
    
  Modelica.Electrical.Analog.Basic.Resistor Rrad(R=1.14) ;
   
  Modelica.SIunits.ActivePower PowerIn;
  Modelica.SIunits.ActivePower PowerOut;

  Modelica.SIunits.Time time0=1;
equation 
  
  connect(SineVoltage1.n, Re.p) ;
  connect(SineVoltage1.p, Ground1.p) ;
  connect(Re.n, Le.p) 
    ;
  connect(Le.n, Le_prim.p) 
    ;
  connect(Le_prim.n, Le_comp.p) ;
  connect(Rdamp.p, Le_prim.n);
  connect(Cmass.p, Le_prim.n) ;
  connect(Cmass.n, Ground1.p) ;
  connect(Rdamp.n, Ground1.p) ;
  connect(Le_comp.n, Ground1.p) ;
  connect(Crad.p, Le_prim.n) 
    ;
  connect(Crad.n, Rrad.p) ;
  connect(Rrad.n, Ground1.p) ;
 der(PowerOut) = Rrad.R*Rrad.p.i^2/time0; 
 der(PowerIn)  = SineVoltage1.n.v*SineVoltage1.n.i/time0;
 
end Speaker;