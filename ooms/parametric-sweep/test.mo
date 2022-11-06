model test
  inner Modelica.SIunits.Frequency freq = 100;
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 5e-07, Tolerance = 1e-06));
  Modelica.Electrical.IC.Components.Ground ground2 annotation(Placement(visible = true, transformation(origin = {-38,-80}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground3 annotation(Placement(visible = true, transformation(origin = {14.5,-79.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {68.5,29}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0, riseTime = 0, fallTime = 0, stepWidth = 1, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {41.5,57.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground4 annotation(Placement(visible = true, transformation(origin = {70.5,-73.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {-1.5,9}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Capacitor capacitor1(W = 4e-06, L = 4e-06) annotation(Placement(visible = true, transformation(origin = {70.5,-22}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.CurrentSource currentsource1(Amplitude = 0, phase = 0, DCcurrent = 1e-05, delay = 0, riseTime = 1, fallTime = 1, stepWidth = 10, I0 = 1e-05, I1 = 1e-05) annotation(Placement(visible = true, transformation(origin = {14.5,-38}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 1, phase = 0, DCVoltage = 1.0, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 1, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-38,-30.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));

equation 
  connect(nmostransistor1.b,ground3.p) annotation(Line(points = {{13.425,9},{43,9},{43,-64.5},{14.5,-64.5},{14.5,-64.5}}));
  connect(voltagesource2.n,ground1.p) annotation(Line(points = {{56.5,57.5},{69,57.5},{69,44},{68.5,44}}));
  connect(nmostransistor1.g,voltagesource1.p) annotation(Line(points = {{-16.575,8.925},{-38,8.925},{-38,-15.5},{-38,-15.5}}));
  connect(voltagesource1.n,ground2.p) annotation(Line(points = {{-38,-45.5},{-38,-45.5},{-38,-65},{-38,-65}}));
  connect(voltagesource2.p,nmostransistor1.d) annotation(Line(points = {{26.5,57.5},{13.5,57.5},{13.5,16.5},{13.5,16.5}}));
  connect(nmostransistor1.s,currentsource1.p) annotation(Line(points = {{13.425,1.425},{14,1.425},{14,-22.5},{14.5,-22.5},{14.5,-23}}));
  connect(currentsource1.n,ground3.p) annotation(Line(points = {{14.5,-53},{14.5,-53},{14.5,-64.5},{14.5,-64.5}}));
  connect(capacitor1.p,nmostransistor1.s) annotation(Line(points = {{70.5,-7},{70,-7},{70,1.5},{13.425,1.5},{13.425,1.425}}));
  connect(capacitor1.n,ground4.p) annotation(Line(points = {{70.5,-37},{70.5,-37},{70.5,-58.5},{70.5,-58.5}}));
end test;

