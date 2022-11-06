within Simulator.Files.Icons;

model CSTR "Basic graphical representation of Continuous Stirred Tank Reactor"

annotation(
     Icon(coordinateSystem(extent = {{-100, -200}, {100, 200}}, initialScale = 0.1), graphics = {Line(origin = {-100, 0}, points = {{0, 82}, {0, -100}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {100, 0}, points = {{0, 82}, {0, -100}}, color = {0, 70, 70}, thickness = 0.3), Text(extent = {{-500, -220}, {500, -280}}, textString = "%name", fontSize = 10), Line(origin = {-0.861648, 80.7908}, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {102, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {-0.475204, -99.4345}, rotation = 180, points = {{-100, 0}, {-85, 20}, {-40, 40}, {40, 40}, {85, 20}, {100, 0}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {0.540426, -3.24255},points = {{-100, 4}, {-87.5, -12}, {-62.5, 20}, {-35.5, -12}, {-12.5, 20}, {12.5, -14}, {37.5, 20}, {64.5, -12}, {87.5, 20}, {100, 2}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {0.419943, 38.6905}, points = {{0, 120}, {0, -138}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {0.794574, -81.1569}, rotation = 180, points = {{-52, -22}, {-51, 16}, {-10, 18}, {14, 18}, {51, 16}, {52, -22}}, color = {0, 70, 70}, thickness = 0.3, smooth = Smooth.Bezier), Line(origin = {-13.7822, -3.69982}, points = {{0, 162}, {0, 136}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {14.5004, -3.54051}, points = {{0, 162}, {0, 136}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-153.713, 131.536}, rotation = -90, points = {{0, 168}, {0, 140}}, color = {0, 70, 70}, thickness = 0.3), Line(origin = {-150.749, 159.26}, rotation = -90, points = {{0, 166}, {0, 138}}, color = {0, 70, 70}, thickness = 0.3)}),
   
    __OpenModelica_commandLineOptions = "",
    
  Documentation(info = "<html>
<p>
Model that has only basic icon for continuous stirred tank reactor unit operation (No declarations and no equations).
</p>
</html>"));

end CSTR;
