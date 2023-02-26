within mbe.c09Architectures.ThermalControl.Interfaces;
partial model Sensor_WithExpandableBus
  "Sensor subsystem interface using an expandable bus"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a room
    "Thermal connection to room"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  mbe.c09Architectures.ThermalControl.Interfaces.ExpandableBus bus
             annotation (Placement(transformation(extent={{90,-10},{110,10}})));
end Sensor_WithExpandableBus;
