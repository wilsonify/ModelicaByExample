model TransmissionGate
  inner Modelica.SIunits.Frequency freq = 10;
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 5e-07, Tolerance = 1e-06));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {32.5,-17}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource4(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {13,13.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource3(Amplitude = 0, phase = 0, DCVoltage = 0, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 0, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {30,80}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 1.2, V1 = 0) annotation(Placement(visible = true, transformation(origin = {22.5,-71}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground3 annotation(Placement(visible = true, transformation(origin = {76,-86.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground2 annotation(Placement(visible = true, transformation(origin = {-83,-66}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.PMOStransistor pmostransistor1 annotation(Placement(visible = true, transformation(origin = {-5.5,57.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1 annotation(Placement(visible = true, transformation(origin = {-5,-44}, extent = {{15,-15},{-15,15}}, rotation = 90)));
  Modelica.Electrical.IC.Components.Capacitor capacitor1 annotation(Placement(visible = true, transformation(origin = {76.5,-4}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 0, phase = 0, DCVoltage = 0.6, delay = 0.001, riseTime = 500, fallTime = 1, stepWidth = 1, V0 = 0, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-83,-20.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.Ground ground4 annotation(Placement(visible = true, transformation(origin = {69.5,57.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));

equation 
  connect(voltagesource3.n,ground4.p) annotation(Line(points = {{45,80},{69.5,80},{69.5,78.5},{69.5,78.5},{69.5,72.5}}));
  connect(voltagesource2.p,nmostransistor1.g) annotation(Line(points = {{7.5,-71},{-5,-71},{-5,-59},{-4.925,-59},{-4.925,-59.075}}));
  connect(voltagesource2.n,ground3.p) annotation(Line(points = {{37.5,-71},{50,-71},{50,-71},{76,-71},{76,-71.5}}));
  connect(voltagesource3.p,pmostransistor1.g) annotation(Line(points = {{15,80},{-5.5,80},{-5.5,73},{-5.575,73},{-5.575,72.575}}));
  connect(nmostransistor1.s,capacitor1.p) annotation(Line(points = {{2.575,-29.075},{56.5,-29.075},{56.5,11},{76.5,11},{76.5,11}}));
  connect(ground1.p,nmostransistor1.b) annotation(Line(points = {{32.5,-2},{32.5,-1.5},{-5.5,-1.5},{-5.5,-29.075},{-5,-29.075}}));
  connect(voltagesource4.n,ground1.p) annotation(Line(points = {{28,13.5},{32.5,13.5},{32.5,-2},{32.5,-2}}));
  connect(voltagesource4.p,pmostransistor1.b) annotation(Line(points = {{-2,13.5},{-5.5,13.5},{-5.5,42.5},{-5.5,42.5},{-5.5,42.575}}));
  connect(nmostransistor1.d,voltagesource1.p) annotation(Line(points = {{-12.5,-29},{-44.5,-29},{-44.5,4.5},{-83.5,4.5},{-83.5,-5.5},{-83,-5.5}}));
  connect(voltagesource1.p,pmostransistor1.s) annotation(Line(points = {{-83,-5.5},{-83.5,-5.5},{-83.5,4},{-44.5,4},{-44.5,43},{-13.075,43},{-13.075,42.575}}));
  connect(voltagesource1.n,ground2.p) annotation(Line(points = {{-83,-35.5},{-83,-35.5},{-83,-51},{-83,-51}}));
  connect(capacitor1.n,ground3.p) annotation(Line(points = {{76.5,-19},{76.5,-19},{76.5,-71.5},{76,-71.5}}));
  connect(pmostransistor1.d,capacitor1.p) annotation(Line(points = {{2,42.5},{56.5,42.5},{56.5,11},{76.5,11}}));
end TransmissionGate;

