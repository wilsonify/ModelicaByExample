within Modelica.Electrical.IC;
package Sources "Contains voltage and current sources"
  extends Modelica.Icons.Library2;
  import SI = Modelica.SIunits;
  import nonSI = Modelica.SIunits.Conversions.NonSIunits;
  import Modelica.Electrical.IC.Functions.*;
  import Modelica.Math;
  import Interfaces = Modelica.Electrical.IC.Interfaces;
  model VoltageSource "voltage source"
    extends Interfaces.OnePort;
    parameter SI.Voltage Amplitude(start = 1) "Amplitude AC signal";
      parameter nonSI.Angle_deg phase = 0 "Phase of AC signal";
      parameter SI.Voltage DCVoltage = 1.2 "DC offset";
      parameter Real delay = 0.1 "Time (in microsecs) when transient step rises";
      parameter Real riseTime = 50 "Time (in nanosecs) which takes signal going from V0 to V1";
	  parameter Real fallTime = 50 "Time (in nanosecs) which takes signal going from V1 to V0";
	  parameter Real stepWidth = 200 "Time (in nanosecs) since signal reachs V1 until it start to fall towards V0";	  
      parameter SI.Voltage V0 = 0 "Low level voltage of the step";
      parameter SI.Voltage V1 = 1 "High level voltage of the step";
      SI.Voltage vAC_mag(start = 0) "Magnitude of AC small-signal voltage";
      SI.Voltage vAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal voltage across the component";
      SI.Current iAC_mag(start = 0) "Magnitude of AC small-signal current";
      SI.Current iAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal current";
      SI.Conversions.NonSIunits.Angle_deg iAC_phase(start = 0) "Phase (deg) of AC small-signal current";
      SI.Voltage pinP_vAC_mag(start = 0) "Magnitude of AC small-signal voltage at positive Pin";
      nonSI.Angle_deg pinP_vAC_phase(start = 0) "Phase (deg) of AC small-signal voltage at positive Pin";
      SI.Voltage pinP_vAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal voltage at positive Pin";
      SI.Voltage pinN_vAC_mag(start = 0) "Magnitude of AC small-signal voltage at negative Pin";
      nonSI.Angle_deg pinN_vAC_phase(start = 0)"Phase (deg) of AC small-signal voltage at negative Pin";
      SI.Voltage pinN_vAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal voltage at negative Pin";
    annotation(Diagram
				(graphics = {Ellipse(rotation = 0, lineColor = {0,0,0}, fillColor = {255,255,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25, extent = {{-50,50},{50,-50}}),
							 Line(points = {{-96,0},{-50,0}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{50,0},{96,0}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{-77,21},{-77,9.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{-83,15},{-72,15}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), 
			  Icon(graphics = {Ellipse(rotation = 0, lineColor = {0,0,0}, fillColor = {255,255,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25, extent = {{-50,50},{50,-50}}),
							 Line(points = {{-90,0},{-50,0}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{50,0},{90,0}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25),
							 Text(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-150,80},{150,120}}, textString = "%name=%I"),
							 Line(points = {{-74.5,20.5},{-74.5,9}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{-80,14.5},{-68.5,14.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}));
  
  equation 
    vDC = DCVoltage;
    vAC_mag = Amplitude;
    vAC_mag_dB = Decibels(vAC_mag);
	{vAC_Re,vAC_Im} = {Amplitude*cos(Deg2Rad(phase)),Amplitude*sin(Deg2Rad(phase))};
    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
	(pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);
    
    (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);
    
	assert((riseTime + fallTime) < stepWidth, "Rise time + fall time is bigger than step width in voltage source parameters");
	
    vTran = if time < (delay * 1e-6) then V0 else 
			if time < ((delay * 1e-6) + (riseTime * 1e-9)) then (V0 + (((V1-V0)/(riseTime * 1e-9))*(time-(delay * 1e-6)))) else 
			if time < ((delay * 1e-6) + (riseTime * 1e-9) + (stepWidth * 1e-9)) then V1 else 
			if time < ((delay * 1e-6) + (riseTime * 1e-9) + (stepWidth * 1e-9) + (fallTime * 1e-9)) then (V1-(((V1-V0)/(fallTime * 1e-9))*(time-((delay * 1e-6)+(riseTime * 1e-9)+(stepWidth * 1e-9))))) 
			else V0;
	
	

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), 
					graphics = {Ellipse(extent = {{-50,50},{50,-50}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),
								Line(points = {{-90,0},{-50,0}}, color = {0,0,0}),
								Line(points = {{50,0},{90,0}}, color = {0,0,0}),
							    Text(extent = {{-150,80},{150,120}}, textString = "%name=%I", lineColor = {0,0,255}),
								Polygon(points = {{90,0},{60,10},{60,-10},{90,0}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid)}), 
			   Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), 
					graphics = {Ellipse(extent = {{-50,50},{50,-50}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),
								Line(points = {{-96,0},{-50,0}}, color = {0,0,0}),
								Line(points = {{50,0},{96,0}}, color = {0,0,0}),
								Line(points = {{0,-50},{0,50}}, color = {0,0,0})}), 
			  Documentation(info = "<HTML>
				<P>
				Voltage source which supply three kind of voltage variables (AC, DC and Transient)
				</P>
				</HTML>
				",revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
				</li>
				</ul>
				</html>"));
  end VoltageSource;
  
  model CurrentSource "Current source"
   extends Interfaces.OnePort;
    parameter SI.Current Amplitude(start = 1) "Amplitude AC signal";
    parameter nonSI.Angle_deg phase = 0 "Phase of AC signal";
    parameter SI.Current DCcurrent = 1e-5 "DC offset";
    parameter Real delay = 0.1 "Time (in microsecs) when transient step rises";
    parameter Real riseTime = 50 "Time (in nanosecs) which takes signal going from V0 to V1";
	parameter Real fallTime = 50 "Time (in nanosecs) which takes signal going from V1 to V0";
	parameter Real stepWidth = 200 "Time (in nanosecs) since signal reachs V1 until it start to fall towards V0";
    parameter SI.Current I0 = 0 "Low level current of the step";
    parameter SI.Current I1 = 1 "High level current of the step";
    SI.Voltage vAC_mag(start = 0) "Magnitude of AC small-signal voltage";
    SI.Voltage vAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal voltage across the component";
	SI.Conversions.NonSIunits.Angle_deg vAC_phase(start = 0) "Phase (deg) of AC small-signal voltage";
    SI.Current iAC_mag(start = 0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start = 0) "Magnitude (dB) of AC small-signal current";
    SI.Voltage pinP_iAC_mag(start = 0) "Magnitude of AC small-signal current at positive Pin";
    nonSI.Angle_deg pinP_iAC_phase(start = 0) "Phase (deg) of AC small-signal current at positive Pin";
    SI.Voltage pinP_iAC_mag_dB(start = 0)"Magnitude (dB) of AC small-signal current at positive Pin";
    SI.Voltage pinN_iAC_mag(start = 0)"Magnitude of AC small-signal voltage at negative Pin";
    nonSI.Angle_deg pinN_iAC_phase(start = 0)"Phase (deg) of AC small-signal current at negative Pin";
    SI.Voltage pinN_iAC_mag_dB(start = 0)"Magnitude (dB) of AC small-signal current at negative Pin";
	
	annotation(Icon(
				graphics = {Ellipse(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{12.5,-36},{-59,36}}),
							Text(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-150,80},{150,120}}, textString = "%name=%I"),
							Ellipse(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{58.5,-36},{-9.5,35}}),
							Polygon(points = {{69,13},{69,-8.5},{83,2},{69,13}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25),
							Line(points = {{61,1.5},{99,1.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Text(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-150,80},{150,120}}, textString = "%name=%I"),
							Line(points = {{-61.5,2.5},{-100,2.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}),
			   Diagram(
				 graphics = {Ellipse(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{12.5,-34},{-60,36}}),
							 Ellipse(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{58.5,-33.5},{-12,36}}),
							 Polygon(points = {{72.5,12.5},{72.5,-9.5},{87,1},{72.5,12.5}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25),
							 Line(points = {{61,1},{99,1}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							 Line(points = {{-63,1},{-99.5,1}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}),
			  Documentation(info = "<HTML>
				<P>
				Current source which supply three kind of current variables (AC, DC and Transient)
				</P>
				</HTML>
				",revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
				</li>
				</ul>
				</html>"));
	
  equation	
	iDC = DCcurrent;
    iAC_mag = Amplitude;
    iAC_mag_dB = Decibels(vAC_mag);
	{iAC_Re,iAC_Im} = {Amplitude*cos(Deg2Rad(phase)),Amplitude*sin(Deg2Rad(phase))};
    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);
	(pinP_iAC_mag,pinP_iAC_phase) = Rect2Polar({p.iAC_Re,p.iAC_Im});
    pinP_iAC_mag_dB = Decibels(pinP_iAC_mag);
    
    (pinN_iAC_mag,pinN_iAC_phase) = Rect2Polar({n.iAC_Re,n.iAC_Im});
    pinN_iAC_mag_dB = Decibels(pinN_iAC_mag);
    
	assert((riseTime + fallTime) < stepWidth, "Rise time + Fall time is bigger than step width in current source parameters");
	
    iTran = if time < (delay * 1e-6) then I0
			else if time > (delay * 1e-06) and time < ((delay*1e-6) + (riseTime*1e-9)) then ((I1-I0)/riseTime*1e-9)*(time-(delay*1e-6)) 
			else if time > (delay * 1e-06)+(riseTime * 1e-9) and time < ((delay * 1e-6)+(riseTime * 1e-9)+(stepWidth * 1e-9)) then I1
			else if time > ((delay * 1e-6)+(riseTime * 1e-9)+(stepWidth * 1e-9)) and time < ((delay * 1e-6)+(riseTime * 1e-9)+(stepWidth * 1e-9)+(fallTime * 1e-9))
					then I1-(((I1-I0)/fallTime*1e-9)*(time-((delay * 1e-6)+(riseTime * 1e-9)+(stepWidth * 1e-9))))
			else I0;
   
  end CurrentSource;
  
  annotation(Documentation(info = "<HTML>
<P>
This package contains two kind of power sources: Voltage and Current sources.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
end Sources;

