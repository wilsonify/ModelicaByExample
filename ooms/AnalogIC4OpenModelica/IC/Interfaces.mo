within Modelica.Electrical.IC;
package Interfaces "Needed connectors for IC design"
extends Modelica.Icons.Library2;
  import SI= Modelica.SIunits;
  
  connector PositivePin 
    SI.Voltage vDC "DC potential at the pin";
    SI.Voltage vTran "Transient/Small-signal potential at the pin";
    SI.Voltage vAC_Re "Small-signal potential at the pin. Real part";
    SI.Voltage vAC_Im "Small-signal potential at the pin. Imaginary part";
    
    flow SI.Current iDC "DC current flowing into the pin";
    flow SI.Current iTran "Transient current flowing into the pin";
    flow SI.Current iAC_Re 
      "Small-signal current flowing into the pin. Real part";
    flow SI.Current iAC_Im 
      "Small-signal current flowing into the pin. Imaginary part";
    
	annotation (defaultComponentName="pin",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-160,110},{40,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Documentation(info = "<HTML>
				<P>
				Superclass of positive pins.
				</P>
				</HTML>
				", revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
					</li>

				</ul>
				</html>"));
  end PositivePin;
  
  connector NegativePin 
    SI.Voltage vDC "DC potential at the pin";
    SI.Voltage vTran "Transient/Small-signal potential at the pin";
    SI.Voltage vAC_Re "Small-signal potential at the pin. Real part";
    SI.Voltage vAC_Im "Small-signal potential at the pin. Imaginary part";
    
    flow SI.Current iDC "DC current flowing into the pin";
    flow SI.Current iTran "Transient current flowing into the pin";
    flow SI.Current iAC_Re 
      "Small-signal current flowing into the pin. Real part";
    flow SI.Current iAC_Im 
      "Small-signal current flowing into the pin. Imaginary part";
    
	annotation (defaultComponentName="pin",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-160,110},{40,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Documentation(info = "<HTML>
				<P>
				Superclass of negative pins.
				</P>
				</HTML>
				", revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
					</li>

				</ul>
				</html>"));
  end NegativePin;
  
  partial model TwoPin 
    PositivePin p "(+) node" annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    NegativePin n "(-) node" annotation (Placement(transformation(extent={{
              90,-10},{110,10}}, rotation=0)));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-120,3},{-110,0},{-120,-3},{-120,3}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{-136,0},{-111,0}}, color={160,160,164}),
          Text(
            extent={{-134,5},{-117,20}},
            lineColor={160,160,164},
            textString="p.i"),
          Line(points={{110,0},{135,0}}, color={160,160,164}),
          Polygon(
            points={{120,3},{110,0},{120,-3},{120,3}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{117,3},{134,18}},
            lineColor={160,160,164},
            textString="n.i")}),
      Documentation(info = "<HTML>
				<P>
				Superclass of elements with two pins.
				</P>
				</HTML>
				", revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
					</li>

				</ul>
				</html>"));
  end TwoPin;
  
  partial model MOSFET 
    PositivePin d "Drain" annotation(Placement(transformation(extent = {{90,40},{110,60}}, rotation = 0)));
    PositivePin s "Source" annotation(Placement(visible = true, transformation(origin = {99.5,-50.5}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {98,-48}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    PositivePin g "Gate"  annotation(Placement(visible = true, transformation(origin = {-100.5,-0.5}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,1}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    PositivePin b "Bulk" annotation(Placement(visible = true, transformation(origin = {99.5,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {99,1}, extent = {{-10,-10},{10,10}}, rotation = 0)));
	annotation(Diagram(
				graphics = {Line(points = {{-96.5,0},{-10.5,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{-10,-50},{-10,50}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,70},{10,19.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,20},{10,-31.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,-30},{10,-71}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,50},{96,50}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,0},{96,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{10,-50},{96,-50}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), 
			   Icon(
			    graphics = {Line(points = {{-94,2},{-15.5,2}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{-15.5,46.5},{-15.5,-39.5}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{4,68},{4,-66}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{100.5,50},{4,50},{4,50},{4,50}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{99,2},{4.5,2}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),
							Line(points = {{99,-48},{4,-48}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}),
			   Documentation(info = "<HTML>
				<P>
				Superclass of NMOS and PMOS transistors which have 4 pins (Gate, Source, Drain and Bulk).
				</P>
				</HTML>
				", revisions = "<html>
				<ul>
				<li><i> 2011   </i>
					by David Malo Cid
					</li>

				</ul>
				</html>"));
  end MOSFET;
  
  partial model OnePort 
	extends TwoPin;
    SI.Voltage vDC "DC voltage between pines";
    SI.Voltage vTran "Transient voltage between pines";
    SI.Voltage vAC_Re "Real part of AC small-signal voltage between pines";
    SI.Voltage vAC_Im "Imaginary part of AC small-signal voltage between pines";
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";
  equation 
    // i, v sign criterion: Positive current flows from 
    // the (+) node through the part to the (-) node
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran,p.iAC_Re,p.iAC_Im};
    {iDC,iTran,iAC_Re,iAC_Im} = -{n.iDC,n.iTran,n.iAC_Re,n.iAC_Im};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};
	  
	annotation (
      Documentation(info="<HTML>
<P>
Superclass of elements which have <b>two</b> electrical pins:
the positive pin connector <i>p</i>, and the negative pin
connector <i>n</i>. It is assumed that the current flowing
into pin p is identical to the current flowing out of pin n.
This current is provided explicitly as current i.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>
</ul>
</html>"));
  end OnePort;
  
  annotation(Documentation(info = "<HTML>
<P>
This package contains different interfaces which are extended by components.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
 end Interfaces;