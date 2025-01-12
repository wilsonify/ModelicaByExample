within mbe.c07Components.Rotational.Interfaces;
partial model Compliant "A compliant rotational component"
  extends mbe.c07Components.Rotational.Interfaces.TwoFlange;
protected
  Modelica.SIunits.Torque tau;
equation
  tau = flange_a.tau;
  flange_a.tau + flange_b.tau = 0
    "Conservation of angular momentum (no storage)";
end Compliant;
