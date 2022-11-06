model TwoStage
  inner Modelica.SIunits.Frequency freq = 10;
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 5e-07, Tolerance = 0.0));
  Modelica.Electrical.IC.Components.Ground ground3 annotation(Placement(visible = true, transformation(origin = {19.5,-90.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1 annotation(Placement(visible = true, transformation(origin = {17.5,-2.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground2 annotation(Placement(visible = true, transformation(origin = {-81,-86}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground4 annotation(Placement(visible = true, transformation(origin = {77,-85}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-80,13}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor2(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {-37,-9.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-80,55}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 1, phase = 0, DCVoltage = 0.9, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 0, V1 = 1) annotation(Placement(visible = true, transformation(origin = {-81,-43}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.Resistor resistor1(W = 0.001, L = 0.06) annotation(Placement(visible = true, transformation(origin = {-22.5,42.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.CurrentSource currentsource1(Amplitude = 0, phase = 0, DCcurrent = 1e-05, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, I0 = 1e-05, I1 = 1e-05) annotation(Placement(visible = true, transformation(origin = {19.5,-48.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.Ground ground5 annotation(Placement(visible = true, transformation(origin = {-22,-81.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Capacitor capacitor1(W = 4e-05, L = 4e-05) annotation(Placement(visible = true, transformation(origin = {77,-43}, extent = {{-15,15},{15,-15}}, rotation = -90)));

equation 
  connect(nmostransistor1.s,capacitor1.p) annotation(Line(points = {{32.425,-10.075},{76.5,-10.075},{76.5,-28},{77,-28}}));
  connect(capacitor1.n,ground4.p) annotation(Line(points = {{77,-58},{77,-58},{77,-70},{77,-70}}));
  connect(ground5.p,nmostransistor2.s) annotation(Line(points = {{-22,-66.5},{-22,-17},{-22.075,-17},{-22.075,-17.075}}));
  connect(nmostransistor1.b,ground3.p) annotation(Line(points = {{32.425,-2.5},{48,-2.5},{48,-75.5},{19.5,-75.5},{19.5,-75.5}}));
  connect(voltagesource2.p,nmostransistor1.d) annotation(Line(points = {{-80,70},{-80,70},{-80,88},{33,88},{33,5},{32.5,5}}));
  connect(nmostransistor2.d,nmostransistor1.g) annotation(Line(points = {{-22,-2},{2.5,-2},{2.5,-2.575},{2.425,-2.575}}));
  connect(currentsource1.p,nmostransistor1.s) annotation(Line(points = {{19.5,-33.5},{19,-33.5},{19,-22.5},{32.5,-22.5},{32.5,-10.075},{32.425,-10.075}}));
  connect(currentsource1.n,ground3.p) annotation(Line(points = {{19.5,-63.5},{19.5,-67},{19.5,-74.5},{19.5,-75.5}}));
  connect(nmostransistor2.b,nmostransistor2.s) annotation(Line(points = {{-22.075,-9.5},{-21.5,-9.5},{-21.5,-17.075},{-22.075,-17.075}}));
  connect(resistor1.p,voltagesource2.p) annotation(Line(points = {{-22.5,57.5},{-22.5,57.5},{-22.5,88},{-80,88},{-80,70},{-80,70}}));
  connect(resistor1.n,nmostransistor2.d) annotation(Line(points = {{-22.5,27.5},{-22,27.5},{-22,-2},{-22,-2}}));
  connect(voltagesource1.p,nmostransistor2.g) annotation(Line(points = {{-81,-28},{-80.5,-28},{-80.5,-9},{-52.075,-9},{-52.075,-9.575}}));
  connect(voltagesource1.n,ground2.p) annotation(Line(points = {{-81,-58},{-81,-58},{-81,-71},{-81,-71}}));
  connect(voltagesource2.n,ground1.p) annotation(Line(points = {{-80,40},{-80,40},{-80,28},{-80,28},{-80,28}}));
end TwoStage;
