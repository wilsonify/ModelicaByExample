within FirstBookExamples.SimpleCar;
package Vehicles "Vehicle models"
  extends Modelica.Icons.Package;
  model PassengerCar "A sample passenger car model"
    Modelica.Mechanics.Translational.Interfaces.Flange_a road annotation (Placement(
          transformation(extent={{-50,-110},{-30,-90}})));
    replaceable Chassis.GenericCar chassis(vehicle_mass=1200) constrainedby
      Interfaces.Chassis annotation (Placement(transformation(extent=
              {{-80,-60},{-20,0}})));
    replaceable Engine.Components.I4_Engine engine(spark_advance=20,
        burn_duration=80) constrainedby Interfaces.Engine
                                                    annotation (Placement(
          transformation(extent={{44,-36},{64,-16}})));
    Engine.GeometrySource geometry(
      bore=0.080,
      stroke=0.080,
      conrod=0.157) annotation (Placement(transformation(extent={{80,
              -36},{100,-16}})));
    Engine.Components.Reservoir intake_manifold annotation (Placement(
          transformation(extent={{20,70},{40,90}})));
    Engine.Components.Reservoir exhaust_manifold annotation (Placement(
          transformation(extent={{60,0},{80,20}})));
    replaceable Transmission.FiveSpeed transmission constrainedby
      Interfaces.Transmission annotation (Placement(transformation(
            extent={{-14,-50},{26,-10}})));
    replaceable Transmission.SimpleShiftStrategy shift_strategy(tire_radius=
          0.35, up_shift_schedule={10,20,30,40}) constrainedby
      Interfaces.ShiftStrategy annotation (Placement(transformation(
            extent={{-14,10},{26,50}})));
    Modelica.Blocks.Interfaces.RealOutput speed annotation (Placement(
          transformation(
          origin={60,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Engine.Components.Manifold intake_manifold1 annotation (Placement(
          transformation(extent={{20,40},{40,60}})));
    Modelica.Blocks.Interfaces.RealInput throttle annotation (Placement(
          transformation(extent={{-120,50},{-100,70}})));
  equation
    connect(chassis.road, road) annotation (Line(points={{-62,-60},{
            -40,-60},{-40,-100}}, color={0,255,0}));
    connect(geometry.geom, engine.engine_geometry) annotation (Line(
          points={{79,-26},{65,-26}}, color={0,0,0}));
    connect(exhaust_manifold.tap, engine.exhaust) annotation (Line(
          points={{70,-5.55112e-16},{70,-18},{64,-18}}, color={255,
            127,0}));
    connect(transmission.engine, engine.crankshaft) annotation (Line(
          points={{26,-30},{44,-30}}, color={128,128,128}));
    connect(transmission.driveline, chassis.power) annotation (Line(
          points={{-14,-30},{-26,-30}}, color={128,128,128}));
    connect(shift_strategy.gear_request, transmission.gear_selector)
      annotation (Line(points={{6,8},{6,-8}}, color={127,0,255}));
    connect(chassis.wheel, shift_strategy.wheel) annotation (Line(
          points={{-56,-48},{-90,-48},{-90,30},{-14,30}}, color={128,
            128,128}));
    connect(chassis.speed, speed) annotation (Line(points={{-32,-63},
            {-32,-80},{60,-80},{60,-110}}));
    connect(intake_manifold1.manifold, engine.intake) annotation (Line(
          points={{30,40},{30,0},{44,-18}}, color={255,127,0}));
    connect(intake_manifold.tap, intake_manifold1.ambient) annotation (Line(
          points={{30,70},{30,60}}, color={255,127,0}));
    connect(intake_manifold1.throttle_angle, throttle) annotation (Line(
          points={{19,50},{10,50},{10,60},{-110,60}}));
    annotation (
      Icon(graphics={
          Polygon(
            points={{-60,-38},{82,-38},{76,-20},{60,-14},{38,-10},{20,
                8},{-28,8},{-38,-10},{-70,-18},{-70,-34},{-60,-38}},
            lineColor={0,0,0},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,-26},{-26,-50}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-48,-28},{-28,-48}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{50,-26},{74,-50}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{52,-28},{72,-48}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,2},{30,-12},{10,-12},{-4,-12},{-4,2},{16,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-72,-28},{-62,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{56,-32},{68,-44}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-44,-32},{-32,-44}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,2},{-12,-12},{-34,-12},{-28,0},{-26,2},{-20,
                2},{-12,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-4,6},{-4,-30},{26,-30},{34,-24},{34,-10},
                {18,6},{-4,6}}, lineColor={128,128,128}),
          Line(points={{-40,-40},{-40,-100}}, color={127,255,0}),
          Text(extent={{-60,40},{60,20}}, textString=
                                              "%name"),
          Line(points={{60,-52},{60,-100}})}),
      Documentation(info="This model brings together a complete vehicle model with an engine, transmission, shift strategy and chassis.
The throttle of the vehicle is presumably controlled by an external \"driver\" model.
"));
  end PassengerCar;

  model SportsCar "Vehicle model with the characteristics of a sports car."
    Modelica.Mechanics.Translational.Interfaces.Flange_a road annotation (Placement(
          transformation(extent={{-50,-110},{-30,-90}})));
    replaceable Chassis.SportsCarChassis chassis annotation (Placement(
          transformation(extent={{-80,-60},{-20,0}})));
    replaceable Engine.Components.I4_Engine engine(
      spark_advance=20,
      burn_duration=60,
      evo=64,
      ivo=165,
      evc=190,
      ivc=290) annotation (Placement(transformation(extent={{44,-36},
              {64,-16}})));
    Engine.SportsCarGeometry geometry annotation (Placement(
          transformation(extent={{80,-36},{100,-16}})));
    Engine.Components.Reservoir intake_ambient annotation (Placement(
          transformation(extent={{19.5365,-0.248949},{39.5365,19.7511}})));
    Engine.Components.Reservoir exhaust_manifold annotation (Placement(
          transformation(extent={{60,0},{80,20}})));
    Transmission.SportsCarTransmission transmission(k_on=2, k_off=6)
      annotation (Placement(transformation(extent={{-14,-50},{26,-10}})));
    Transmission.SimpleShiftStrategy shift_strategy(tire_radius=0.35,
        up_shift_schedule={30,60,80,95}) annotation (Placement(
          transformation(extent={{-52.4692,31.6109},{-12.4692,71.6109}})));
    Modelica.Blocks.Interfaces.RealOutput speed annotation (Placement(
          transformation(
          origin={60,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    connect(chassis.road, road) annotation (Line(points={{-62,-60},{
            -40,-60},{-40,-100}}, color={0,255,0}));
    connect(geometry.geom, engine.engine_geometry) annotation (Line(
          points={{79,-26},{65,-26}}, color={0,0,0}));
    connect(exhaust_manifold.tap, engine.exhaust) annotation (Line(
          points={{70,-5.55112e-16},{70,-18},{64,-18}}, color={255,
            127,0}));
    connect(transmission.engine, engine.crankshaft) annotation (Line(
          points={{26,-30},{44,-30}}, color={128,128,128}));
    connect(transmission.driveline, chassis.power) annotation (Line(
          points={{-14,-30},{-26,-30}}, color={128,128,128}));
    connect(chassis.wheel, shift_strategy.wheel) annotation (Line(
          points={{-56,-48},{-80,-48},{-80,52},{-52.4692,52}}, color=
            {128,128,128}));
    connect(chassis.speed, speed) annotation (Line(points={{-32,-63},
            {-32,-80},{60,-80},{60,-110}}));
    connect(shift_strategy.gear_request, transmission.gear_selector)
      annotation (Line(points={{-32,30},{-32,0},{6,0},{6,-8}}));
    connect(intake_ambient.tap, engine.intake) annotation (Line(
          points={{30,0},{30,-18},{44,-18}}, color={255,127,0}));
    annotation (
      Icon(graphics={
          Polygon(
            points={{-62,-40},{80,-40},{74,-22},{58,-16},{36,-12},{18,
                6},{-30,6},{-40,-12},{-72,-20},{-72,-36},{-62,-40}},
            lineColor={0,0,0},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-52,-28},{-28,-52}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,-30},{-30,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{48,-28},{72,-52}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{50,-30},{70,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,2},{30,-12},{10,-12},{-4,-12},{-4,2},{16,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,-30},{-64,-36}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{54,-34},{66,-46}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-46,-34},{-34,-46}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,2},{-12,-12},{-34,-12},{-28,0},{-26,2},{-20,
                2},{-12,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-6,4},{-6,-32},{24,-32},{32,-26},{32,-12},
                {16,4},{-6,4}}, lineColor={128,128,128}),
          Line(points={{-40,-40},{-40,-100}}, color={127,255,0}),
          Text(extent={{-60,40},{60,20}}, textString=
                                              "%name"),
          Line(points={{60,-52},{60,-100}})}));
  end SportsCar;
  annotation (
    Documentation(info="This package contains several \"complete vehicle\" models.  These are models
that combine the engine, transmission and chassis subsystems from the other
parts of the 'SimpleCar' package into a complete vehicle."),
    Icon(graphics={
        Polygon(
          points={{-73,-44},{69,-44},{63,-26},{47,-20},{25,-16},{7,2},
              {-41,2},{-51,-16},{-83,-24},{-83,-40},{-73,-44}},
          lineColor={0,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-63,-32},{-39,-56}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{37,-32},{61,-56}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-61,-34},{-41,-54}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-57,-38},{-45,-50}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{39,-34},{59,-54}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{43,-38},{55,-50}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-17,0},{-17,-36},{13,-36},{21,-30},{21,-16},
              {5,0},{-17,0}}, lineColor={128,128,128}),
        Rectangle(
          extent={{-85,-34},{-75,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-25,-3},{-25,-17},{-47,-17},{-41,-5},{-39,-3},{-33,
              -3},{-25,-3}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{5,-3},{19,-17},{-1,-17},{-15,-17},{-15,-3},{5,-3}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}));

end Vehicles;
