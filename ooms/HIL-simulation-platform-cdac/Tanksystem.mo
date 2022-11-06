package Tanksystem
  package Interfaces
    connector Port "a connector which transfers the variables"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {255,0,0}, fillPattern = FillPattern.Solid, extent = {{ -21,40},{19,1}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {255,0,0}, fillPattern = FillPattern.Solid, extent = {{ -31,38},{11, -2}})}));
      flow Modelica.SIunits.MassFlowRate M "unit is Kg/s" ;
      Modelica.SIunits.Pressure P "unit is Pascal" ;
      annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
    end Port ;
    connector Levelsensor "Reading fluid level"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Text(lineColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.55, extent = {{ -47,36},{ -5, -17}}, textString = "LEVEL SENSOR")}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(points = {{12.0,12.0}}),Text(lineColor = {0,153,153}, fillColor = {204,204,204}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.55, extent = {{ -41,26},{8, -31}}, textString = "Level Sensor")}));
      Modelica.SIunits.Height L "unit is m" ;
    end Levelsensor ;
  end Interfaces ;
  annotation(uses(Modelica(version = "3.0")), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
  package components
    model Source "Constant pressure Source"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.55, extent = {{ -36,43},{27, -15}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.55, extent = {{ -31,43},{25, -6}})}));
      parameter Modelica.SIunits.Pressure P = 2.6 ;
      Tanksystem.Interfaces.Port sourceoutlet annotation(Placement(transformation(x = 26.572815, y = 15.03398, scale = 0.21000001), iconTransformation(x = 28.393204, y = 8.359223, scale = 0.21000001))) ;

    equation 
      sourceoutlet.P = P;
    end Source ;
    model Controlvalve1 "A linear control valve"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, points = {{ -38.0,33.0},{ -38.0,9.0},{ -38.0,9.0},{0.0,33.0},{0.0,8.0},{0.0,8.0}}),Line(points = {{ -19.0,21.0},{ -19.0,41.0},{ -18.0,41.0}}, thickness = 3.55),Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -31,49},{ -6,41}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(points = {{ -46.0,49.0}}),Polygon(points = {{ -38.0,57.0}}),Polygon(points = {{ -38.0,39.0},{ -39.0,39.0}}),Polygon(fillColor = {0,153,153}, fillPattern = FillPattern.Sphere, lineThickness = 1.25, points = {{ -36.0,31.0},{ -36.0,10.0},{1.0,30.0},{1.0,9.0}}),Line(points = {{ -17.0,20.0},{ -17.0,38.0},{ -17.0,39.0}}, thickness = 3.45),Ellipse(fillColor = {0,153,153}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -26,44},{ -8,39}})}));
      parameter Real cd = 0.028112 ;
      parameter Modelica.SIunits.Density row = 985.185 ;
      Tanksystem.Interfaces.Port valveinlet annotation(Placement(transformation(x =  -33.27311, y = 16.84874, scale = 0.21000001), iconTransformation(x =  -38.0, y = 20.0, scale = 0.21000001))) ;
      Tanksystem.Interfaces.Port valveoutlet annotation(Placement(transformation(x = 1.1796117, y = 15.954693, scale = 0.21000001, aspectRatio = 0.7971015), iconTransformation(x = 3.0, y = 16.0, scale = 0.21000001))) ;

    equation 
      valveinlet.M + valveoutlet.M = 0;
      valveinlet.M = cd * row * (valveinlet.P - valveoutlet.P);
    end Controlvalve1 ;
    model Tank "A tank model with inlet at top and outlet at bottom"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Rectangle(lineColor = {102,102,102}, fillColor = {255,255,255}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.55, extent = {{ -38,25},{19, -37}}),Rectangle(fillColor = {102,255,255}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.15, extent = {{ -38, -8},{19, -38}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
      parameter Modelica.SIunits.Area a = 1 ;
      parameter Modelica.SIunits.Density row = 985.185 ;
      parameter Modelica.SIunits.Height tank_ele = 10 ;
      parameter Real convNM2 = 0.0001 ;
      parameter Modelica.SIunits.Pressure P = 1.033 ;
      Modelica.SIunits.Height h(start = 1.234) ;
      Real result ;
      Tanksystem.Interfaces.Port tankinlet annotation(Placement(transformation(x =  -36.286728, y = 30.786407, scale = 0.18272969, aspectRatio = 1.1492385), iconTransformation(x =  -38.107117, y = 15.532362, scale = 0.18272969, aspectRatio = 0.9327153))) ;
      Tanksystem.Interfaces.Port tankoutlet annotation(Placement(transformation(x = 25.82039, y =  -13.145632, scale = 0.21000001), iconTransformation(x = 18.538837, y =  -34.32538, scale = 0.21000001, aspectRatio = 0.85576266))) ;
      Tanksystem.Interfaces.Levelsensor tsensor annotation(Placement(transformation(x = 28.946764, y = 34.742718, scale = 0.21000001), iconTransformation(x = 24.291264, y = 13.504854, scale = 0.21000001))) ;

    equation 
      der(h) = (tankinlet.M + tankoutlet.M) / (row * a);
      tankoutlet.P = P + (h + tank_ele) * row * convNM2;
      tankinlet.P = P;
      tsensor.L = h;
      when sample(0, 0.5) then
              result = ModelicaPrint("C:\\PROCESS1.txt", h);
      
      end when;
    end Tank ;
    model Sink "Constant pressure Sink "
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {0,153,153}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.45, extent = {{ -24,38},{21, -11}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.45, extent = {{ -25,35},{21, -12}})}));
      parameter Modelica.SIunits.Pressure P = 1.033 ;
      Tanksystem.Interfaces.Port sinkinlet annotation(Placement(transformation(x =  -26.0, y = 7.6067963, scale = 0.19173914, aspectRatio = 0.9841269), iconTransformation(x =  -28.0, y = 8.0, scale = 0.21000001))) ;

    equation 
      sinkinlet.P = P;
    end Sink ;
    model Controlvalve2
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, points = {{ -38.0,33.0},{ -38.0,9.0},{ -38.0,9.0},{0.0,33.0},{0.0,8.0},{0.0,8.0}}),Line(points = {{ -19.0,21.0},{ -19.0,41.0},{ -18.0,41.0}}, thickness = 3.55),Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -31,49},{ -6,41}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(points = {{ -46.0,49.0}}),Polygon(points = {{ -38.0,57.0}}),Polygon(points = {{ -38.0,39.0},{ -39.0,39.0}}),Polygon(fillColor = {0,153,153}, fillPattern = FillPattern.Sphere, lineThickness = 1.25, points = {{ -36.0,31.0},{ -36.0,10.0},{1.0,30.0},{1.0,9.0}}),Line(points = {{ -17.0,20.0},{ -17.0,38.0},{ -17.0,39.0}}, thickness = 3.45),Ellipse(fillColor = {0,153,153}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -26,44},{ -8,39}})}));
      Real cdcv2 ;
      Real outValue ;
      parameter Modelica.SIunits.Density row = 985.19 ;
      Tanksystem.Interfaces.Port valveinletcv2 annotation(Placement(transformation(x =  -35.39256, y = 17.288698, scale = 0.11002613, aspectRatio = 1.4135818), iconTransformation(x =  -38.0, y = 18.0, scale = 0.21000001))) ;
      Tanksystem.Interfaces.Port valveoutletcv2 annotation(Placement(transformation(x = 1.1796117, y = 15.954693, scale = 0.21000001, aspectRatio = 0.7971015), iconTransformation(x = 3.0, y = 16.0, scale = 0.21000001))) ;

    equation 
      valveinletcv2.M + valveoutletcv2.M = 0;
      outValue = ModelicaRead("C:\\OUTFILE1.txt", time);
      cdcv2 = 0.28112 * outValue;
      valveinletcv2.M = row * cdcv2 * (valveinletcv2.P - valveoutletcv2.P);
    end Controlvalve2 ;
    model Tank2 "A tank model with inlet at top and outlet at bottom"
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Rectangle(lineColor = {102,102,102}, fillColor = {255,255,255}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.55, extent = {{ -38,25},{19, -37}}),Rectangle(fillColor = {102,255,255}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.15, extent = {{ -38, -8},{19, -38}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
      parameter Modelica.SIunits.Area a = 1 ;
      parameter Modelica.SIunits.Density row = 985.185 ;
      parameter Modelica.SIunits.Height tank_ele = 10 ;
      parameter Real convNM2 = 0.0001 ;
      parameter Modelica.SIunits.Pressure P = 1.033 ;
      Modelica.SIunits.Height h2(start = 1.234) ;
      Real result ;
      Tanksystem.Interfaces.Port tankinlet annotation(Placement(transformation(x =  -36.286728, y = 30.786407, scale = 0.18272969, aspectRatio = 1.1492385), iconTransformation(x =  -38.107117, y = 15.532362, scale = 0.18272969, aspectRatio = 0.9327153))) ;
      Tanksystem.Interfaces.Port tankoutlet annotation(Placement(transformation(x = 25.82039, y =  -13.145632, scale = 0.21000001), iconTransformation(x = 18.538837, y =  -34.32538, scale = 0.21000001, aspectRatio = 0.85576266))) ;
      Tanksystem.Interfaces.Levelsensor tsensor annotation(Placement(transformation(x = 28.946764, y = 34.742718, scale = 0.21000001), iconTransformation(x = 24.291264, y = 13.504854, scale = 0.21000001))) ;

    equation 
      der(h2) = (tankinlet.M + tankoutlet.M) / (row * a);
      tankoutlet.P = P + (h2 + tank_ele) * row * convNM2;
      tankinlet.P = P;
      tsensor.L = h2;
      when sample(0, 0.5) then
              result = ModelicaPrint("C:\\PROCESS2.txt", h2);
      
      end when;
    end Tank2 ;
    model Controlvalve3
      annotation(Icon(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, points = {{ -38.0,33.0},{ -38.0,9.0},{ -38.0,9.0},{0.0,33.0},{0.0,8.0},{0.0,8.0}}),Line(points = {{ -19.0,21.0},{ -19.0,41.0},{ -18.0,41.0}}, thickness = 3.55),Ellipse(fillColor = {0,204,204}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -31,49},{ -6,41}})}), Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Polygon(points = {{ -46.0,49.0}}),Polygon(points = {{ -38.0,57.0}}),Polygon(points = {{ -38.0,39.0},{ -39.0,39.0}}),Polygon(fillColor = {0,153,153}, fillPattern = FillPattern.Sphere, lineThickness = 1.25, points = {{ -36.0,31.0},{ -36.0,10.0},{1.0,30.0},{1.0,9.0}}),Line(points = {{ -17.0,20.0},{ -17.0,38.0},{ -17.0,39.0}}, thickness = 3.45),Ellipse(fillColor = {0,153,153}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 1.25, extent = {{ -26,44},{ -8,39}})}));
      Real cdcv3 ;
      Real outValue3 ;
      parameter Modelica.SIunits.Density row = 985.19 ;
      Tanksystem.Interfaces.Port valveinletcv3 annotation(Placement(transformation(x =  -35.39256, y = 17.288698, scale = 0.11002613, aspectRatio = 1.4135818), iconTransformation(x =  -38.0, y = 18.0, scale = 0.21000001))) ;
      Tanksystem.Interfaces.Port valveoutletcv3 annotation(Placement(transformation(x = 1.1796117, y = 15.954693, scale = 0.21000001, aspectRatio = 0.7971015), iconTransformation(x = 3.0, y = 16.0, scale = 0.21000001))) ;

    equation 
      valveinletcv3.M + valveoutletcv3.M = 0;
      outValue3 = ModelicaRead("C:\\OUTFILE2.txt", time);
      cdcv3 = 0.28112 * outValue3;
      valveinletcv3.M = row * cdcv3 * (valveinletcv3.P - valveoutletcv3.P);
    end Controlvalve3 ;
  end components ;
  function ModelicaPrint "a function which writes the value into a file"
    input String fileName ;
    input Real z ;
    output Real y ;
    annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));

    external  y = ModelicaPrint(fileName,z)     annotation(Library = "libModelicaPrint.o", Include = "#include \"ModelicaPrint.h\"");
  end ModelicaPrint ;
  function ModelicaRead
    input String fileName ;
    input Real z ;
    output Real y ;

    external  y = ModelicaRead(fileName,z)     annotation(Library = "libModelicaRead.o", Include = "#include \"ModelicaRead.h\"");
  end ModelicaRead ;
  model Onetanksystem
    annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Text(extent = {{ -60,66},{ -88,61}}, textString = "Source"),Text(extent = {{ -48,66},{ -35,61}}, textString = "CV1"),Text(extent = {{ -7, -2},{10,7}}, textString = "Tank"),Text(extent = {{42, -19},{53, -11}}, textString = "CV2"),Text(extent = {{84, -18},{69, -12}}, textString = "Sink"),Text(extent = {{ -62, -57},{61, -47}}, textString = "ONE TANK CONTROL SYSTEM", textStyle = {TextStyle.Bold})}));
    Tanksystem.components.Source S1 annotation(Placement(transformation(x =  -70.0, y = 21.0, scale = 0.21000001), iconTransformation(x =  -70.6068, y = 47.097088, scale = 0.21000001))) ;
    Tanksystem.components.Controlvalve1 CV1 annotation(Placement(transformation(x =  -39.0, y = 21.0, scale = 0.21000001), iconTransformation(x =  -39.0, y = 44.96602, scale = 0.21000001))) ;
    Tanksystem.components.Controlvalve2 CV2 annotation(Placement(transformation(x = 29.0, y =  -6.0, scale = 0.21000001), iconTransformation(x = 54.9466, y =  -6.914778, scale = 0.21000001, aspectRatio = 1.0962962))) ;
    Tanksystem.components.Tank T1 annotation(Placement(transformation(x =  -10.0, y = 24.0, scale = 0.21000001), iconTransformation(x = 5.9559107, y = 28.586761, scale = 0.412136, aspectRatio = 1.0402725))) ;
    Tanksystem.components.Sink S2 annotation(Placement(transformation(x = 54.0, y =  -6.0, scale = 0.21000001), iconTransformation(x = 88.181755, y =  -5.165697, scale = 0.28566176, aspectRatio = 0.93742424))) ;

  equation 
    connect(CV2.valveoutletcv2,S2.sinkinlet) annotation(Line(points = {{56.0, -3.0},{80.0, -3.0}}));
    connect(S1.sourceoutlet,CV1.valveinlet) annotation(Line(points = {{ -65.0,49.0},{ -47.0,49.0},{ -47.0,50.0}}));
    connect(CV1.valveoutlet,T1.tankinlet) annotation(Line(points = {{ -39.0,48.0},{ -11.0,48.0},{ -11.0,39.0}}));
    connect(T1.tankoutlet,CV2.valveinletcv2) annotation(Line(points = {{15.0,16.0},{46.0,16.0},{46.0, -2.0}}));
  end Onetanksystem ;
  model Twotanksystem
    annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Text(extent = {{ -79,59},{ -99,55}}, textString = "Source"),Text(extent = {{ -76,24},{ -57,20}}, textString = "CV1"),Text(extent = {{ -51,1},{ -29, -21}}, textString = "Tank 'T1'"),Text(extent = {{1,8},{ -10,27}}, textString = "CV2"),Text(extent = {{43, -4},{19, -18}}, textString = "Tank 'T2'"),Text(extent = {{51,16},{66,20}}, textString = "CV3"),Text(extent = {{91,5},{75,29}}, textString = "Sink"),Text(extent = {{ -59, -30},{73, -69}}, textString = "TWO TANK CONTROL SYSTEM", textStyle = {TextStyle.Bold})}));
    Tanksystem.components.Source S1 annotation(Placement(transformation(x =  -69.0, y = 56.0, scale = 0.21000001), iconTransformation(x =  -89.70441, y = 38.148777, scale = 0.190243, aspectRatio = 1.363585))) ;
    Tanksystem.components.Controlvalve1 CV1 annotation(Placement(transformation(x =  -92.0, y = 49.0, scale = 0.21000001), iconTransformation(x =  -60.005104, y = 35.780018, scale = 0.14622226, aspectRatio = 1.3947904))) ;
    Tanksystem.components.Controlvalve2 CV2 annotation(Placement(transformation(x = 10.0, y = 27.0, scale = 0.21000001), iconTransformation(x = 1.4395909, y =  -1.6233009, scale = 0.19561881, aspectRatio = 0.85881317))) ;
    Tanksystem.components.Controlvalve3 CV3 annotation(Placement(transformation(x = 54.0, y = 18.0, scale = 0.21000001), iconTransformation(x = 61.333553, y =  -3.2467284, scale = 0.20395589, aspectRatio = 0.94010097))) ;
    Tanksystem.components.Tank T1 annotation(Placement(transformation(x =  -13.0, y = 25.0, scale = 0.21000001), iconTransformation(x =  -37.359226, y = 7.8883495, scale = 0.21000001, aspectRatio = 1.0434844))) ;
    Tanksystem.components.Tank2 T2 annotation(Placement(transformation(x = 22.0, y = 22.0, scale = 0.21000001), iconTransformation(x = 26.598597, y = 7.3194547, scale = 0.2006667, aspectRatio = 1.0706588))) ;
    Tanksystem.components.Sink S2 annotation(Placement(transformation(x = 90.0, scale = 0.21000001), iconTransformation(x = 86.238976, y =  -1.765373, scale = 0.25977778, aspectRatio = 0.9341316))) ;

  equation 
    connect(S1.sourceoutlet,CV1.valveinlet) annotation(Line(points = {{ -84.0,40.0},{ -66.0,40.0}}));
    connect(CV1.valveoutlet,T1.tankinlet) annotation(Line(points = {{ -60.0,39.0},{ -56.0,14.0},{ -46.0,12.0}}));
    connect(T1.tankoutlet,CV2.valveinletcv2) annotation(Line(points = {{ -33.0,1.0},{ -6.0,2.0}}));
    connect(CV2.valveoutletcv2,T2.tankinlet) annotation(Line(points = {{2.0,1.0},{17.0,1.0},{19.0,11.0}}));
    connect(T2.tankoutlet,CV3.valveinletcv3) annotation(Line(points = {{30.0,0.0},{53.0,1.0},{53.0,1.0}}));
    connect(CV3.valveoutletcv3,S2.sinkinlet) annotation(Line(points = {{62.0,0.0},{79.0,0.0}}));
  end Twotanksystem ;
  model Threetanksystem
    annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}}), graphics = {Text(extent = {{ -98,67},{ -85,61}}, textString = "Source"),Text(extent = {{ -68,64},{ -61,60}}, textString = "CV1"),Text(extent = {{ -40, -15},{ -54, -5}}, textString = "Tank 'T1'"),Text(extent = {{ -28, -7},{ -22, -5}}, textString = "CV2"),Text(extent = {{ -6, -6},{7, -16}}, textString = "Tank 'T2'"),Text(extent = {{24, -7},{18, -3}}, textString = "CV3"),Text(extent = {{59, -8},{45, -10}}, textString = "Tank 'T3'"),Text(extent = {{75, -4},{80, -7}}, textString = "CV4"),Text(extent = {{68, -34},{78, -37}}, textString = "Sink"),Text(fillColor = {204,204,255}, extent = {{ -54, -69},{57, -81}}, textString = "THREE TANK CONTROL SYSTEM", textStyle = {TextStyle.Bold})}));
    Tanksystem.components.Source S1 annotation(Placement(transformation(x =  -90.0, y = 11.0, scale = 0.21000001), iconTransformation(x =  -90.902916, y = 42.86408, scale = 0.21000001))) ;
    Tanksystem.components.Controlvalve1 CV1 annotation(Placement(transformation(x =  -76.0, y =  -23.0, scale = 0.21000001), iconTransformation(x =  -62.519417, y = 41.64563, scale = 0.21000001))) ;
    Tanksystem.components.Controlvalve1 CV2 annotation(Placement(transformation(x =  -13.0, y = 19.0, scale = 0.21000001), iconTransformation(x =  -24.883495, y =  -3.2572815, scale = 0.21000001))) ;
    Tanksystem.components.Controlvalve1 CV3 annotation(Placement(transformation(x = 38.0, y = 18.0, scale = 0.21000001), iconTransformation(x = 23.160492, y =  -2.1876063, scale = 0.21036817, aspectRatio = 0.88075966))) ;
    Tanksystem.components.Controlvalve1 CV4 annotation(Placement(transformation(x = 69.0, y = 18.0, scale = 0.21000001), iconTransformation(x = 77.59409, y =  -2.3454514, scale = 0.1665656, aspectRatio = 1.0555302))) ;
    Tanksystem.components.Tank T1 annotation(Placement(transformation(x =  -41.0, y = 24.0, scale = 0.21000001), iconTransformation(x =  -45.76242, y = 10.986656, scale = 0.21571071, aspectRatio = 1.2575372))) ;
    Tanksystem.components.Tank T2 annotation(Placement(transformation(x = 11.0, y = 22.0, scale = 0.21000001), iconTransformation(x = 1.5683825, y = 9.826912, scale = 0.19782607, aspectRatio = 1.2056928))) ;
    Tanksystem.components.Tank T3 annotation(Placement(transformation(x = 53.0, y = 23.0, scale = 0.21000001), iconTransformation(x = 50.755768, y = 9.011324, scale = 0.19133334, aspectRatio = 1.2931576))) ;
    Tanksystem.components.Sink S2 annotation(Placement(transformation(x = 36.0, y =  -18.0, scale = 0.21000001), iconTransformation(x = 93.49915, y =  -38.371292, scale = 0.2758328, aspectRatio = 0.902711))) ;

  equation 
    connect(S1.sourceoutlet,CV1.valveinlet) annotation(Line(points = {{ -85.0,45.0},{ -71.0,45.0}}));
    connect(T1.tankoutlet,CV2.valveinlet) annotation(Line(points = {{ -42.0,2.0},{ -32.0,2.0},{ -33.0,1.0}}));
    connect(T2.tankoutlet,CV3.valveinlet) annotation(Line(points = {{5.0,2.0},{15.0,2.0}}));
    connect(T3.tankoutlet,CV4.valveinlet) annotation(Line(points = {{54.0,1.0},{71.0,1.0}}));
    connect(CV3.valveoutlet,T3.tankinlet) annotation(Line(points = {{24.0,1.0},{43.0,1.0},{43.0,13.0}}));
    connect(CV1.valveoutlet,T1.tankinlet) annotation(Line(points = {{ -62.0,45.0},{ -62.0,16.0},{ -54.0,16.0}}));
    connect(CV4.valveoutlet,S2.sinkinlet) annotation(Line(points = {{78.0,1.0},{85.0,1.0},{85.0,0.0},{85.0, -35.0},{86.0, -35.0}}));
    connect(T2.tankinlet,CV2.valveoutlet) annotation(Line(points = {{ -6.0,14.0},{ -7.0,1.0},{ -24.0,1.0}}));
  end Threetanksystem ;
end Tanksystem;

