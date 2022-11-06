model CurrentMirror
  inner Modelica.SIunits.Frequency freq = 100;
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 3e-07, Tolerance = 1e-06));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {12,-13.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-39,-74.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground2 annotation(Placement(visible = true, transformation(origin = {48.5,-73}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor2(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {-54,-13.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 1, riseTime = 10, fallTime = 10, stepWidth = 100, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {74.5,34.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.CurrentSource currentsource1(Amplitude = 1, phase = 0, DCcurrent = 1e-05, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, I0 = 0, I1 = 1) annotation(Placement(visible = true, transformation(origin = {-40,34.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 0, phase = 0, DCVoltage = 0.4, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 0.4, V1 = 0.4) annotation(Placement(visible = true, transformation(origin = {27.5,32}, extent = {{-15,15},{15,-15}}, rotation = -90)));

equation 
  connect(nmostransistor1.b,nmostransistor1.s) annotation(Line(points = {{26.925,-13.5},{27.5,-13.5},{27.5,-21.075},{26.925,-21.075}}));
  connect(nmostransistor1.s,ground2.p) annotation(Line(points = {{26.925,-21.075},{27.5,-21.075},{27.5,-58.5},{48.5,-58.5},{48.5,-58}}));
  connect(nmostransistor2.s,ground1.p) annotation(Line(points = {{-39.075,-21.075},{-39,-21.075},{-39,-59.5},{-39,-59.5}}));
  connect(currentsource1.p,voltagesource1.p) annotation(Line(points = {{-40,49.5},{-40,49.5},{-40,70},{74.5,70},{74.5,49.5},{74.5,49.5}}));
  connect(voltagesource2.p,voltagesource1.p) annotation(Line(points = {{27.5,47},{27,47},{27,70},{74.5,70},{74.5,49.5},{74.5,49.5}}));
  connect(nmostransistor1.g,nmostransistor2.g) annotation(Line(points = {{-3.075,-13.575},{-11,-13.575},{-11,-39.5},{-69,-39.5},{-69,-13.575},{-69.075,-13.575}}));
  connect(voltagesource2.n,nmostransistor1.d) annotation(Line(points = {{27.5,17},{27.5,17},{27.5,-6},{27,-6}}));
  connect(currentsource1.n,nmostransistor2.d) annotation(Line(points = {{-40,19.5},{-39.5,19.5},{-39.5,-6},{-39,-6}}));
  connect(nmostransistor2.g,nmostransistor2.d) annotation(Line(points = {{-69.075,-13.575},{-69,-13.575},{-69,0.5},{-39.5,0.5},{-39.5,-6},{-39,-6}}));
  connect(nmostransistor2.b,nmostransistor2.s) annotation(Line(points = {{-39.075,-13.5},{-39,-13.5},{-39,-21.075},{-39.075,-21.075}}));
  connect(voltagesource1.n,ground2.p) annotation(Line(points = {{74.5,19.5},{74,19.5},{74,-58.5},{48.5,-58.5},{48.5,-58}}));
end CurrentMirror;

