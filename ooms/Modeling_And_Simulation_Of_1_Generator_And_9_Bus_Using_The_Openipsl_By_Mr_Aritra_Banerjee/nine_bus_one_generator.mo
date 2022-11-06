model nine_bus_one_generator
  OpenIPSL.Electrical.Buses.Bus bus1(P_0 = 0.569694 * 100, Q_0 = 0.161003 * 100, V_0 = 1.000000, V_b = 33, angle_0 = 0.000000, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  OpenIPSL.Electrical.Buses.Bus bus2(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.990832, V_b = 33, angle_0 = -1.841601, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus3(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.988817, V_b = 33, angle_0 = -2.113870, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus4(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.989400, V_b = 33, angle_0 = -2.038240, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus5(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.992598, V_b = 33, angle_0 = -1.614710, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus6(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.993416, V_b = 33, angle_0 = -1.508827, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus7(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.992598, V_b = 33, angle_0 = -1.614710, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus8(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.989400, V_b = 33, angle_0 = -2.038240, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus9(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.989400, V_b = 33, angle_0 = -2.113870, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-84, -22}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(B = 0., G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-30, -28}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine4(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {30, -28}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine5(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {60, -20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine6(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {60, 20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine7(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {30, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine8(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine9(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-30, 12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine10(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine11(B = 0, G = 0, R = 0, X = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {30, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine12(B = 0, G = 0, R = 0, X = 0.2, opening = 3, t1 = 5, t2 = 5.8)  annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant1(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.992598, angle_0 = -1.614710)  annotation(
    Placement(visible = true, transformation(origin = {-61, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant2(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.989400, V_b = 33, angle_0 = -2.038240)  annotation(
    Placement(visible = true, transformation(origin = {-43, -13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant3(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.988817, V_b = 33, angle_0 = -2.113870)  annotation(
    Placement(visible = true, transformation(origin = {-59, -53}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant4(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.993416, V_b = 33, angle_0 = -1.508827)  annotation(
    Placement(visible = true, transformation(origin = {-1, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant5(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.992598, V_b = 33, angle_0 = -1.614710)  annotation(
    Placement(visible = true, transformation(origin = {59, 57}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant6(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.989400, V_b = 33, angle_0 = -2.038240)  annotation(
    Placement(visible = true, transformation(origin = {39, -11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant7(P_0 = 0.030360 * 100, Q_0 = 0.012933 * 100, V_0 = 0.988817, V_b = 33, angle_0 = -2.113870)  annotation(
    Placement(visible = true, transformation(origin = {61, -53}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  OpenIPSL.Electrical.Loads.PSAT.VoltDependant voltDependant8(P_0 = 0.113190 * 100, Q_0 = 0.022984 * 100, V_0 = 0.990832, V_b = 33, angle_0 = -1.841601)  annotation(
    Placement(visible = true, transformation(origin = {1, -53}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  OpenIPSL.Electrical.Machines.PSAT.Order2 order21(D = 0, M = 1, P_0 = 0.988817 * 100, Q_0 = 0.161003 * 100, Sn = 100, V_0 = 1.000000, V_b = 33, Vn = 33, angle_0 = 0.000000, ra = 0, x1d = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {19, -13}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  inner OpenIPSL.Electrical.SystemBase sysData(S_b = 100, fn = 50)  annotation(
    Placement(visible = true, transformation(origin = {4, -78}, extent = {{-18, -14}, {18, 14}}, rotation = 0)));
  OpenIPSL.Electrical.Events.PwFault pwFault1(R = 0, X = 10e-8, t1 = 8, t2 = 8.5)  annotation(
    Placement(visible = true, transformation(origin = {-26, -56}, extent = {{-6, -6}, {6, 6}}, rotation = 270)));
equation
  connect(bus7.p, pwLine1.p) annotation(
    Line(points = {{-60, 40}, {-60, 40}, {-60, 24}, {-60, 24}}, color = {0, 0, 255}));
  connect(pwLine1.n, bus8.p) annotation(
    Line(points = {{-60, 16}, {-60, 16}, {-60, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(bus2.p, pwLine3.n) annotation(
    Line(points = {{0, -40}, {-6, -40}, {-6, -28}, {-26, -28}, {-26, -28}}, color = {0, 0, 255}));
  connect(bus2.p, pwLine4.p) annotation(
    Line(points = {{0, -40}, {6, -40}, {6, -28}, {26, -28}, {26, -28}, {26, -28}}, color = {0, 0, 255}));
  connect(bus3.p, pwLine4.n) annotation(
    Line(points = {{60, -40}, {52, -40}, {52, -28}, {34, -28}, {34, -28}}, color = {0, 0, 255}));
  connect(bus9.p, pwLine3.p) annotation(
    Line(points = {{-60, -40}, {-54, -40}, {-54, -28}, {-34, -28}, {-34, -28}}, color = {0, 0, 255}));
  connect(bus4.p, pwLine5.p) annotation(
    Line(points = {{60, 0}, {60, 0}, {60, -16}, {60, -16}}, color = {0, 0, 255}));
  connect(pwLine5.n, bus3.p) annotation(
    Line(points = {{60, -24}, {60, -24}, {60, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(bus5.p, pwLine6.p) annotation(
    Line(points = {{60, 40}, {60, 40}, {60, 24}, {60, 24}}, color = {0, 0, 255}));
  connect(pwLine6.n, bus4.p) annotation(
    Line(points = {{60, 16}, {60, 16}, {60, 0}, {60, 0}}, color = {0, 0, 255}));
  connect(bus6.p, pwLine7.p) annotation(
    Line(points = {{0, 40}, {6, 40}, {6, 30}, {26, 30}, {26, 30}}, color = {0, 0, 255}));
  connect(bus5.p, pwLine7.n) annotation(
    Line(points = {{60, 40}, {52, 40}, {52, 30}, {34, 30}, {34, 30}}, color = {0, 0, 255}));
  connect(bus7.p, pwLine8.p) annotation(
    Line(points = {{-60, 40}, {-54, 40}, {-54, 30}, {-34, 30}, {-34, 30}}, color = {0, 0, 255}));
  connect(bus6.p, pwLine8.n) annotation(
    Line(points = {{0, 40}, {-6, 40}, {-6, 30}, {-26, 30}, {-26, 30}}, color = {0, 0, 255}));
  connect(bus7.p, pwLine9.p) annotation(
    Line(points = {{-60, 40}, {-56, 40}, {-56, 12}, {-34, 12}, {-34, 12}}, color = {0, 0, 255}));
  connect(pwLine9.n, bus1.p) annotation(
    Line(points = {{-26, 12}, {-6, 12}, {-6, 0}, {0, 0}}, color = {0, 0, 255}));
  connect(bus6.p, pwLine10.p) annotation(
    Line(points = {{0, 40}, {0, 40}, {0, 24}, {0, 24}}, color = {0, 0, 255}));
  connect(pwLine10.n, bus1.p) annotation(
    Line(points = {{0, 16}, {0, 0}}, color = {0, 0, 255}));
  connect(bus5.p, pwLine11.n) annotation(
    Line(points = {{60, 40}, {54, 40}, {54, 14}, {34, 14}, {34, 14}}, color = {0, 0, 255}));
  connect(pwLine11.p, bus1.p) annotation(
    Line(points = {{26, 14}, {8, 14}, {8, 0}, {0, 0}}, color = {0, 0, 255}));
  connect(bus1.p, pwLine12.p) annotation(
    Line(points = {{0, 0}, {0, 0}, {0, -16}, {0, -16}}, color = {0, 0, 255}));
  connect(pwLine12.n, bus2.p) annotation(
    Line(points = {{0, -24}, {0, -24}, {0, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(bus7.p, voltDependant1.p) annotation(
    Line(points = {{-60, 40}, {-60, 40}, {-60, 50}, {-60, 50}}, color = {0, 0, 255}));
  connect(bus8.p, voltDependant2.p) annotation(
    Line(points = {{-60, 0}, {-52, 0}, {-52, -6}, {-42, -6}, {-42, -8}, {-42, -8}}, color = {0, 0, 255}));
  connect(bus9.p, voltDependant3.p) annotation(
    Line(points = {{-60, -40}, {-60, -40}, {-60, -48}, {-58, -48}}, color = {0, 0, 255}));
  connect(bus2.p, voltDependant8.p) annotation(
    Line(points = {{0, -40}, {2, -40}, {2, -48}, {2, -48}}, color = {0, 0, 255}));
  connect(bus3.p, voltDependant7.p) annotation(
    Line(points = {{60, -40}, {60, -40}, {60, -48}, {62, -48}}, color = {0, 0, 255}));
  connect(bus6.p, voltDependant4.p) annotation(
    Line(points = {{0, 40}, {-2, 40}, {-2, 52}, {0, 52}}, color = {0, 0, 255}));
  connect(bus5.p, voltDependant5.p) annotation(
    Line(points = {{60, 40}, {58, 40}, {58, 52}, {60, 52}}, color = {0, 0, 255}));
  connect(bus4.p, voltDependant6.p) annotation(
    Line(points = {{60, 0}, {54, 0}, {54, -4}, {38, -4}, {38, -6}, {40, -6}}, color = {0, 0, 255}));
  connect(order21.pm0, order21.pm) annotation(
    Line(points = {{24, -8}, {24, -8}, {24, -6}, {26, -6}, {26, -10}, {26, -10}}, color = {0, 0, 127}));
  connect(order21.vf0, order21.vf) annotation(
    Line(points = {{24, -18}, {24, -18}, {24, -20}, {26, -20}, {26, -16}, {26, -16}}, color = {0, 0, 127}));
  connect(pwLine2.n, bus9.p) annotation(
    Line(points = {{-84, -26}, {-84, -26}, {-84, -36}, {-60, -36}, {-60, -40}, {-60, -40}}, color = {0, 0, 255}));
  connect(pwLine2.p, bus8.p) annotation(
    Line(points = {{-84, -18}, {-84, -18}, {-84, -4}, {-60, -4}, {-60, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(pwFault1.p, bus2.p) annotation(
    Line(points = {{-26, -48}, {-26, -48}, {-26, -40}, {0, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(order21.p, bus1.p) annotation(
    Line(points = {{14, -12}, {4, -12}, {4, 0}, {2, 0}, {2, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
  annotation(
    uses(OpenIPSL(version = "1.5.0")));
end nine_bus_one_generator;
