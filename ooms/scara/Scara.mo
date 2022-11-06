model Scara
  inner Modelica.Mechanics.MultiBody.World world(gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity, n = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {-78, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Giunto1(diameter = 0.1, length = 0.3, r = {0, 0, 0.3}, r_shape = {0, 0, 0})  annotation(
    Placement(visible = true, transformation(origin = {-46, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Giunto2(diameter = 0.1, length = 0.3, r = {0, 0.3, 0}, r_shape = {0, 0, 0})  annotation(
    Placement(visible = true, transformation(origin = {20, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange = true, w(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-12, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(useAxisFlange = true, w(fixed = false)) annotation(
    Placement(visible = true, transformation(origin = {52, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder Giunto3(diameter = 0.1, length = 0.3, r = {0, 0.3, 0}, r_shape = {0, 0, 0}, v_0(start = {0, 0, 5})) annotation(
    Placement(visible = true, transformation(origin = {80, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox1(animation = true, height = 0.05, length = 0.4, r = {0, 0, 0.4}, v_0(start = {0.1, 0.1, 3}), width = 0.05)  annotation(
    Placement(visible = true, transformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic1(a(fixed = false), n = {0, 0, 1}, s(fixed = false), useAxisFlange = true, v(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {90, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines.DC_PermanentMagnet dcpm annotation(
    Placement(visible = true, transformation(origin = {-24, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.QuasiStationaryDCMachines.DC_PermanentMagnet dcpm1 annotation(
    Placement(visible = true, transformation(origin = {32, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T1 annotation(
    Placement(visible = true, transformation(origin = {48, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm2 annotation(
    Placement(visible = true, transformation(origin = {-24, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(
    Placement(visible = true, transformation(origin = {-86, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
    Placement(visible = true, transformation(origin = {-86, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_braccio1p annotation(
    Placement(visible = true, transformation(origin = {-86, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_braccio1n annotation(
    Placement(visible = true, transformation(origin = {-86, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_braccio2p annotation(
    Placement(visible = true, transformation(origin = {-86, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_braccio2n annotation(
    Placement(visible = true, transformation(origin = {-86, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pin_braccio1p, dcpm.pin_ap) annotation(
    Line(points = {{-86, 98}, {-18, 98}, {-18, 90}, {-18, 90}}, color = {0, 0, 255}));
  connect(pin_braccio1n, dcpm.pin_an) annotation(
    Line(points = {{-86, 82}, {-30, 82}, {-30, 90}, {-30, 90}}, color = {0, 0, 255}));
  connect(pin_braccio2p, dcpm1.pin_ap) annotation(
    Line(points = {{-86, 64}, {38, 64}, {38, 90}, {38, 90}}, color = {0, 0, 255}));
  connect(pin_braccio2n, dcpm1.pin_an) annotation(
    Line(points = {{-86, 50}, {26, 50}, {26, 90}, {26, 90}}, color = {0, 0, 255}));
  connect(pin_p, dcpm2.pin_ap) annotation(
    Line(points = {{-86, 32}, {-18, 32}, {-18, 16}, {-18, 16}}, color = {0, 0, 255}));
  connect(pin_n, dcpm2.pin_an) annotation(
    Line(points = {{-86, 16}, {-30, 16}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(dcpm2.flange, idealGearR2T1.flangeR) annotation(
    Line(points = {{-14, 6}, {38, 6}}));
  connect(dcpm.flange, revolute1.axis) annotation(
    Line(points = {{-14, 80}, {-12, 80}, {-12, 56}}));
  connect(idealGearR2T1.flangeT, prismatic1.axis) annotation(
    Line(points = {{58, 6}, {96, 6}, {96, 4}, {96, 4}}, color = {0, 127, 0}));
  connect(dcpm1.flange, revolute2.axis) annotation(
    Line(points = {{42, 80}, {42, 67}, {52, 67}, {52, 56}}));
  connect(prismatic1.frame_b, bodyBox1.frame_a) annotation(
    Line(points = {{90, 2}, {90, -20}}, color = {95, 95, 95}));
  connect(Giunto3.frame_b, prismatic1.frame_a) annotation(
    Line(points = {{90, 46}, {90, 22}}, color = {95, 95, 95}));
  connect(Giunto1.frame_a, world.frame_b) annotation(
    Line(points = {{-56, 46}, {-68, 46}, {-68, -12}}, color = {95, 95, 95}));
  connect(revolute1.frame_a, Giunto1.frame_b) annotation(
    Line(points = {{-22, 46}, {-36, 46}}, color = {95, 95, 95}));
  connect(revolute2.frame_b, Giunto3.frame_a) annotation(
    Line(points = {{62, 46}, {70, 46}}, color = {95, 95, 95}));
  connect(Giunto2.frame_b, revolute2.frame_a) annotation(
    Line(points = {{30, 46}, {42, 46}}, color = {95, 95, 95}));
  connect(revolute1.frame_b, Giunto2.frame_a) annotation(
    Line(points = {{-2, 46}, {10, 46}}, color = {95, 95, 95}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Documentation(info = "Scara model robot. Ony mechanical part and motors. 
It works inputting the voltage reference of the Axis. Jacobian is J= [0.3xV1t, 0.3xcos(V1t) + 0.3xcos(V2t), 0,3xcos(V1t) + 0.3xcos(V2t)][0.3xV1t, 0.3xsen(V1t) + 0.3xsen(V2t), 0.3xsen(V1t) + 0.3xsen(V2t)]
[0.3, 0.3, 0.3 + V3t] . All conversion ratio are equal to 1 and motor are modellized with 12V DC motor."),
  Icon(graphics = {Ellipse(origin = {-39, -70}, fillPattern = FillPattern.Solid, extent = {{-39, 8}, {39, -8}}, endAngle = 360), Line(origin = {17, -4}, points = {{-59, -61.9987}, {-59, 38.0013}, {5, 10.0013}, {59, 34.0013}, {59, 62.0013}}, color = {0, 0, 255}, thickness = 2.5), Ellipse(origin = {-43, 35}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{3, -3}, {-3, 3}}, endAngle = 360), Ellipse(origin = {21, 5}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{3, -3}, {-3, 3}}, endAngle = 360), Rectangle(origin = {77, 29}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Vertical, extent = {{-3, 3}, {3, -3}})}, coordinateSystem(initialScale = 0.1)));
end Scara;