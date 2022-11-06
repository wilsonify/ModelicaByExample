within Simulator.Files.Icons;

model HeatExchanger "Basic graphical representation of Heat Exchanger"
  annotation(
    Icon(graphics = {Ellipse(lineColor = {0, 70, 70}, lineThickness = 0.3,extent = {{-100, 100}, {100, -100}}, endAngle = 360), Line(points = {{-100, 0}, {-35, 30}, {35, -30}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3), Text(extent = {{-500, -120}, {500, -180}}, textString = "%name", fontSize = 10)}, coordinateSystem(initialScale = 0.1)),
  Documentation(info = "<html>
<p>
Model that has only basic icon for heat exchanger unit operation (No declarations and no equations).
</p>
</html>"));
end HeatExchanger;
