model CMOSInverter
  inner Modelica.SIunits.Frequency freq = 10;
  annotation(experiment(StartTime = 0.0, StopTime = 5.5e-07, Tolerance = 1e-06), Diagram());
  Modelica.Electrical.IC.Components.Ground ground2 annotation(Placement(visible = true, transformation(origin = {64,-69}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.NMOStransistor nmostransistor1(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {13.5,-7}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground4 annotation(Placement(visible = true, transformation(origin = {-35.5,-76.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground3 annotation(Placement(visible = true, transformation(origin = {-60.5,4.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Components.Ground ground1 annotation(Placement(visible = true, transformation(origin = {28.5,-56.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource2(Amplitude = 1, phase = 0, DCVoltage = 0.6, delay = 0.1, riseTime = 50, fallTime = 50, stepWidth = 200, V0 = 0, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-36,-31}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.Capacitor capacitor1(W = 4e-06, L = 4e-06) annotation(Placement(visible = true, transformation(origin = {64,-21.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));
  Modelica.Electrical.IC.Components.PMOStransistor pmostransistor1(L = 1e-07, W = 4e-06) annotation(Placement(visible = true, transformation(origin = {11.5,37.5}, extent = {{15,15},{-15,-15}}, rotation = 180)));
  Modelica.Electrical.IC.Sources.VoltageSource voltagesource1(Amplitude = 0, phase = 0, DCVoltage = 1.2, delay = 0, riseTime = 0, fallTime = 0, stepWidth = 0, V0 = 1.2, V1 = 1.2) annotation(Placement(visible = true, transformation(origin = {-60.5,47.5}, extent = {{-15,15},{15,-15}}, rotation = -90)));

equation 
  connect(voltagesource1.n,ground3.p) annotation(Line(points = {{-60.5,32.5},{-60.5,41.5},{-60.5,19.5},{-60.5,19.5}}));
  connect(voltagesource1.p,pmostransistor1.s) annotation(Line(points = {{-60.5,62.5},{-61,62.5},{-61,76.5},{-4,76.5},{-4,45.075},{-3.425,45.075}}));
  connect(capacitor1.n,ground2.p) annotation(Line(points = {{64,-36.5},{64,-36.5},{64,-54},{64,-54}}));
  connect(capacitor1.p,nmostransistor1.d) annotation(Line(points = {{64,-6.5},{64,-6.5},{64,0.5},{28.5,0.5},{28.5,0.5}}));
  connect(pmostransistor1.d,nmostransistor1.d) annotation(Line(points = {{-3.5,30},{-4,30},{-4,10.5},{28.5,10.5},{28.5,0.5},{28.5,0.5}}));
  connect(voltagesource2.n,ground4.p) annotation(Line(points = {{-36,-46},{-36,-46},{-36,-61.5},{-35.5,-61.5}}));
  connect(voltagesource2.p,nmostransistor1.g) annotation(Line(points = {{-36,-16},{-36,-16},{-36,-7},{-1.575,-7},{-1.575,-7.075}}));
  connect(pmostransistor1.b,pmostransistor1.s) annotation(Line(points = {{-3.425,37.5},{-3.5,37.5},{-3.5,45.075},{-3.425,45.075}}));
  connect(pmostransistor1.g,nmostransistor1.g) annotation(Line(points = {{26.575,37.575},{42,37.575},{42,15.5},{-1.5,15.5},{-1.5,-8.5},{-1.575,-8.5},{-1.575,-7.075}}));
  connect(nmostransistor1.s,ground1.p) annotation(Line(points = {{28.425,-14.575},{29,-14.575},{29,-41.5},{28.5,-41.5}}));
  connect(nmostransistor1.b,nmostransistor1.s) annotation(Line(points = {{28.425,-7},{29,-7},{29,-14.575},{28.425,-14.575}}));
end CMOSInverter;

