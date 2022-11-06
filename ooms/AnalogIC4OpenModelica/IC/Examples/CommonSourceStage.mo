model CommonSourceStage
  inner Modelica.SIunits.Frequency freq = 100;
  annotation(uses(Modelica(version = "3.1")), Diagram(), experiment(StartTime = 0.0, StopTime = 1.5e-06, Tolerance = 0.0));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1(L = 1e-07, W = 2e-05) annotation(Placement(visible = true, transformation(origin = {12,-13.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-7.5,-81}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Capacitor capacitor1(W = 0.00012, L = 0.00012) annotation(Placement(visible = true, transformation(origin = {72,-43}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.Resistor resistor1(W = 0.001, L = 0.03) annotation(Placement(visible = true, transformation(origin = {27.5,36}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 1, phase = 0, DCVoltage = 0.7, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 0, V1 = 1) annotation(Placement(visible = true, transformation(origin = {-36.5,-38.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0, riseTime = 0, fallTime = 0, stepWidth = 1, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-68,25}, extent = {{-15,15},{15,-15}}, rotation = -90)));

equation 
  connect(voltagesource2.p,nmostransistor1.g) annotation(Line(points = {{-36.5,-23.5},{-37,-23.5},{-37,-13},{-3.075,-13},{-3.075,-13.575}}));
  connect(voltagesource2.n,ground1.p) annotation(Line(points = {{-36.5,-53.5},{-36,-53.5},{-36,-65.5},{-7.5,-65.5},{-7.5,-66}}));
  connect(voltagesource1.n,ground1.p) annotation(Line(points = {{-68,10},{-67,10},{-67,-66},{-7.5,-66},{-7.5,-66}}));
  connect(voltagesource1.p,resistor1.p) annotation(Line(points = {{-68,40},{-68,40},{-68,65.5},{28,65.5},{28,51},{27.5,51}}));
  connect(nmostransistor1.b,nmostransistor1.s) annotation(Line(points = {{26.85,-13.35},{27,-13.35},{27,-20.7},{26.7,-20.7}}));
  connect(nmostransistor1.s,ground1.p) annotation(Line(points = {{26.7,-20.7},{27,-20.7},{27,-65.5},{-7.5,-65.5},{-7.5,-66}}));
  connect(ground1.p,capacitor1.n) annotation(Line(points = {{-7.5,-66},{-7.5,-65.5},{72,-65.5},{72,-58},{72,-58}}));
  connect(nmostransistor1.d,capacitor1.p) annotation(Line(points = {{27,-6},{72,-6},{72,-28}}));
  connect(resistor1.n,nmostransistor1.d) annotation(Line(points = {{27.5,21},{27,21},{27,-6}}));
end CommonSourceStage;

