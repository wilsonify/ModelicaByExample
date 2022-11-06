within Modelica.Electrical.IC;

package Components "Contains different components"
extends Modelica.Icons.Library2;
  import SI= Modelica.SIunits;
  import nonSI = Modelica.SIunits.Conversions.NonSIunits;
  import INTERFACE = Modelica.Electrical.IC.Interfaces;
  import Modelica.Electrical.IC.Functions.*;
  
  model Resistor "Ideal integrated electrical resistor"
    extends INTERFACE.OnePort;
	import Modelica.Electrical.IC.Constants.ResistorConstants.*;
    parameter SI.Distance W = 1 "Width of the resistor";
    parameter SI.Distance L = 20 "Length of the resistor";
    
    SI.Resistance R "Total resistance of the resistor";
    
    
    SI.Voltage vAC_mag(start=0) "Magnitude of AC small-signal voltage across the component";
    SI.Voltage vAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal voltage across the component";
    nonSI.Angle_deg vAC_phase(start=0) "Phase (deg) of AC small-signal voltage across the component";

    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";
    
    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    
    SI.Voltage pinP_vAC_mag(start=0);
    nonSI.Angle_deg pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);
    
    SI.Voltage pinN_vAC_mag(start=0);
    nonSI.Angle_deg pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);
    
equation
  //Calculation of total resistance
  R = Rs*(L/W);
  
  assert(R > 50, "Resistance has a value lower than 50 Ohms, it is a very low value. Make sure that is the one you want");
  assert(R < 10000000, "Resistance has a value higher than 10 MOhms, it is a very high value. Make sure that is the one you want");
  
  //DC Analysis
  vDC = R*iDC;
  
  //Transient Analysis
  vTran = R*iTran;
  
  //Small-signal Analysis
  {vAC_Re,vAC_Im} = R*{iAC_Re,iAC_Im};
  
  //Magnitude and phase calculations
  (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
   pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);
    
  (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
   pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);
    
  (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
   vAC_mag_dB = Decibels(vAC_mag);
    
  (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
   iAC_mag_dB = Decibels(iAC_mag);
  

  annotation (
    Documentation(info="<HTML>
<P>
The integrated electrical resistor gives us a relation between voltage <i>v</i> current <i>i</i> by <i>i*R = v</i>.<br>
The resistance <i>R</i> cames defined by sheet resistance, length and width of the resistor: <i>R = Rs * L/W</i>.<br>
The resistance can only be positive or zero.
</P>
</HTML>
",
 revisions="<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-152,87},{148,47}},
            textString="%name",
            lineColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255})}));
end Resistor;


model Capacitor "Ideal integrated parallel-plate capacitor"
  extends INTERFACE.OnePort;
  outer SI.Frequency freq "AC small-signal analysis frequency";
  import Modelica.Electrical.IC.Constants.CapacitorConstants.*;
  parameter SI.Distance W = 4e-6 "Width of the capacitor";
  parameter SI.Distance L = 4e-6 "Length of the capacitor";
  
  SI.Capacitance C "Capacitance of the capacitor";
  
  SI.Voltage vAC_mag(start=0) "Magnitude of AC small-signal voltage across the component";
  SI.Voltage vAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal voltage across the component";
  nonSI.Angle_deg vAC_phase(start=0) "Phase (deg) of AC small-signal voltage across the component";

  SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
  SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";
   
  nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    
  SI.Voltage pinP_vAC_mag(start=0);
  nonSI.Angle_deg pinP_vAC_phase(start=0);
  SI.Voltage pinP_vAC_mag_dB(start=0);
    
  SI.Voltage pinN_vAC_mag(start=0);
  nonSI.Angle_deg pinN_vAC_phase(start=0);
  SI.Voltage pinN_vAC_mag_dB(start=0);
  
  equation
  //Capacitance calculation
  C = (0.0885 * (W*L*Er*1e12)/(t*1e10))*1e-12;
  
  assert(C > 1e-15, "Capacitor has a value lower than 1 femtoFaradio, it is a very low value. Make sure that is the one you want");
  assert(C < 1e-9, "Capacitor has a value higher than 1 nanoFaradio, it is a very high value. Make sure that is the one you want");
  
  //DC Analysis
  iDC = 0;
  
  //Transient Analysis
  iTran = C * der(vTran);
  
  //Small-signal Analysis
  {vAC_Re,vAC_Im}*(2*pi*freq*C) = {iAC_Im,-iAC_Re};
  
  //Magnitude and phase calculations
  (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
   pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);
    
  (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
   pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);
    
  (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
   vAC_mag_dB = Decibels(vAC_mag);
    
  (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
   iAC_mag_dB = Decibels(iAC_mag);
  
   annotation (
      Documentation(info="<HTML>
<p>
The linear capacitor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = C * dv/dt</i>.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-14,28},{-14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{14,28},{14,-28}},
            thickness=0.5,
            color={0,0,255}),
          Line(points={{-90,0},{-14,0}}, color={0,0,255}),
          Line(points={{14,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-150,85},{150,45}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-20,40},{-20,-40}},
            thickness=0.5,
            color={0,0,255}),
          Line(
            points={{20,40},{20,-40}},
            thickness=0.5,
            color={0,0,255}),
          Line(points={{-96,0},{-20,0}}, color={0,0,255}),
          Line(points={{20,0},{96,0}}, color={0,0,255})}));
end Capacitor;

model Inductor
extends INTERFACE.OnePort;
  outer SI.Frequency freq "AC small-signal analysis frequency";
  import Modelica.Electrical.IC.Constants.InductorConstants.*;
  parameter SI.Inductance L = 50e-9 "Inductance of the inductor";
  
    SI.Voltage vAC_mag(start=0) "Magnitude of AC small-signal voltage across the inductor";
    SI.Voltage vAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal voltage across the inductor";
    nonSI.Angle_deg vAC_phase(start=0) "Phase (deg) of AC small-signal voltage across the inductor";
    
    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";
    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    
	SI.Voltage pinP_vAC_mag(start=0);
    SI.Voltage pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);
    
    SI.Voltage pinN_vAC_mag(start=0);
    SI.Voltage pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);

	equation
	
	//DC analysis
	vDC = 0;
	
	//Transient analysis
	vTran = L * der(iTran);
	
	//AC analysis
	{vAC_Re,vAC_Im} = {iAC_Im,-iAC_Re}*(2*pi*freq*L);
	
	(pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);
	
	(pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);
    
    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);
    
    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
	
	annotation(Documentation(info = "<HTML>
<P>
The linear inductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by  <i>v = L * di/dt</i>.
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>
</ul>
</html>"), 
	Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), 
		graphics = {Ellipse(extent = {{-60,-15},{-30,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{-30,-15},{0,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{0,-15},{30,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{30,-15},{60,15}}, lineColor = {0,0,255}),
					Rectangle(extent = {{-60,-30},{60,0}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),
					Line(points = {{60,0},{90,0}}, color = {0,0,255}),
					Line(points = {{-90,0},{-60,0}}, color = {0,0,255}),
					Text(extent = {{-138,-60},{144,-94}}, lineColor = {0,0,0}, textString = "L=%L"),
					Text(extent = {{-152,79},{148,39}}, textString = "%name", lineColor = {0,0,255})}), 
	Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), 
		graphics = {Ellipse(extent = {{-60,-15},{-30,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{-30,-15},{0,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{0,-15},{30,15}}, lineColor = {0,0,255}),
					Ellipse(extent = {{30,-15},{60,15}}, lineColor = {0,0,255}),
					Rectangle(extent = {{-60,-30},{60,0}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),
					Line(points = {{60,0},{96,0}}, color = {0,0,255}),
					Line(points = {{-96,0},{-60,0}}, color = {0,0,255})}));
	
end Inductor;

model Ground
 INTERFACE.PositivePin p annotation(Placement(transformation(origin = {0,100}, extent = {{10,-10},{-10,10}}, rotation = 270)));

equation
{p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} = zeros(4);

annotation(Documentation(info = "<HTML>
<P>
Ground of an electrical circuit. The potential at the
ground node is zero. Every electrical circuit has to contain
at least one ground object.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>
</ul>
</html>"), 
   Icon(coordinateSystem(preserveAspectRatio = true, 
		extent = {{-100,-100},{100,100}}, 
		grid = {2,2}), 
		graphics = {Line(points = {{-60,50},{60,50}}, color = {0,0,255}),
			   Line(points = {{-40,30},{40,30}}, color = {0,0,255}),
			   Line(points = {{-20,10},{20,10}}, color = {0,0,255}),
			   Line(points = {{0,90},{0,50}}, color = {0,0,255}),
			   Text(extent = {{-144,-19},{156,-59}}, 
			   textString = "%name", lineColor = {0,0,255})}), 
   Diagram(coordinateSystem(preserveAspectRatio = true, 
		extent = {{-100,-100},{100,100}}, grid = {2,2}), 
		graphics = {Line(points = {{-60,50},{60,50}}, thickness = 0.5, color = {0,0,255}),
			   Line(points = {{-40,30},{40,30}}, thickness = 0.5, color = {0,0,255}),
			   Line(points = {{-20,10},{20,10}}, thickness = 0.5, color = {0,0,255}),
			   Line(points = {{0,96},{0,50}}, thickness = 0.5, color = {0,0,255})}));
end Ground;

model NMOStransistor "Spice Level 1 NMOS transistor model"
      extends INTERFACE.MOSFET;
      import Modelica.Electrical.IC.Constants.NMOStransistorConstants.*;
      inner SI.Voltage vdsDC "Drain to source voltage";
      inner SI.Voltage vgsDC "Gate to source voltage";
      inner SI.Voltage vbsDC "Bulk to source voltage";
      inner SI.Voltage vdsTran "Drain to source voltage";
      inner SI.Voltage vgsTran "Gate to source voltage";
      inner SI.Voltage vbsTran "Bulk to source voltage";
      SI.Voltage drain_vAC_mag "Magnitude of AC small-signal drain voltage";
      SI.Voltage drain_vAC_mag_dB "Magnitude (dB) of AC small-signal drain voltage";
      nonSI.Angle_deg drain_vAC_phase(start = 0) "Phase (deg) of AC small-signal drain voltage";
      SI.Voltage source_vAC_mag "Magnitude of AC small-signal source voltage";
      SI.Voltage source_vAC_mag_dB "Magnitude (dB) of AC small-signal source voltage";
      nonSI.Angle_deg source_vAC_phase(start = 0) "Phase (deg) of drain AC small-signal source voltage";
      SI.Voltage bulk_vAC_mag "Magnitude of AC small-signal bulk voltage";
      SI.Voltage bulk_vAC_mag_dB "Magnitude (dB) of AC small-signal bulk voltage";
      nonSI.Angle_deg bulk_vAC_phase(start = 0) "Phase (deg) of AC small-signal bulk voltage";
      SI.Voltage gate_vAC_mag "Magnitude of AC small-signal gate voltage";
      SI.Voltage gate_vAC_mag_dB "Magnitude (dB) of AC small-signal gate voltage";
      nonSI.Angle_deg gate_vAC_phase(start = 0) "Phase (deg) of AC small-signal gate voltage";
      SI.Current drain_iAC_mag "Magnitude of AC small-signal drain current";
      SI.Current drain_iAC_mag_dB "Magnitude (dB) of AC small-signal drain current";
      nonSI.Angle_deg drain_iAC_phase(start = 0) "Phase (deg) of AC small-signal drain current";
      SI.Current source_iAC_mag "Magnitude of AC small-signal source current";
      SI.Current source_iAC_mag_dB "Magnitude (dB) of AC small-signal source current";
      nonSI.Angle_deg source_iAC_phase(start = 0) "Phase (deg) of drain AC small-signal source current";
      SI.Current bulk_iAC_mag "Magnitude of AC small-signal bulk current";
      SI.Current bulk_iAC_mag_dB "Magnitude (dB) of AC small-signal bulk current";
      nonSI.Angle_deg bulk_iAC_phase(start = 0) "Phase (deg) of AC small-signal bulk current";
      SI.Current gate_iAC_mag "Magnitude of AC small-signal gate current";
      SI.Current gate_iAC_mag_dB "Magnitude (dB) of AC small-signal gate current";
      nonSI.Angle_deg gate_iAC_phase(start = 0) "Phase (deg) of AC small-signal gate current";
      parameter SI.Length L = 1e-7 "Gate length";
      parameter SI.Length W = 4e-6 "Gate width";
      inner SI.Voltage vdsDCSgn "Drain-pin to source-pin voltage";
      inner SI.Voltage vthDC "Threshold voltage";
      inner SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";
      inner SI.Voltage vthTran "Threshold voltage";
      inner SI.Voltage gate_vAC_Re;
      inner SI.Voltage gate_vAC_Im;
      inner SI.Voltage bulk_vAC_Re;
      inner SI.Voltage bulk_vAC_Im;
      NMOS.Ids Ids1(VTO = VTO, GAMMA = GAMMA, PHI = PHI, KP = KP, W = W, L = L, LD = LD, LAMBDA = LAMBDA) annotation(extent = [-10,0;10,20], rotation = -90);
      NMOS.Idiode Dbs(IS = IS) annotation(extent = [40,-25;60,-5], rotation = 180);
      NMOS.Cdiode Cbs(CJ = CJ, CJSW = CJSW, MJ = MJ, MJSW = MJSW, FC = FC, PB = PB, P = PS, A = AS) annotation(extent = [40,-50;60,-30], rotation = 180);
      NMOS.Idiode Dbd(IS = IS) annotation(extent = [40,25;60,45], rotation = 180);
      NMOS.Cdiode Cbd(CJ = CJ, CJSW = CJSW, MJ = MJ, MJSW = MJSW, FC = FC, PB = PB, P = PD, A = AD) annotation(extent = [40,50;60,70], rotation = 180);
      NMOS.Cgd Cgd1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGDO = CGDO, CGSO = CGSO, gateSourcePinsC = false) annotation(extent = [-60,25;-40,45], rotation = 0);
      NMOS.Cgd Cgs1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGDO = CGDO, CGSO = CGSO, gateSourcePinsC = true) annotation(extent = [-60,-25;-40,-5], rotation = 0);
      NMOS.Cgb Cgb1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGBO = CGBO) annotation(extent = [-60,-65;-40,-45], rotation = 0);
      
	  annotation(Diagram(
				   graphics = {Polygon(points = {{41.5,-44.5},{41.5,-55},{60,-50},{41.5,-44.5}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25)}), 
				 Icon(
				   graphics = {Polygon(points = {{31.5,-42},{31.5,-54.5},{53.5,-48.5},{31.5,-42},{31.5,-42}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25)}),
				 Documentation(info = "<HTML>
					<P>
					Model of an NMOS transistor.
					</P>
					</HTML>
					", revisions = "<html>
					<ul>
					<li><i> 2011   </i>
						by David Malo Cid
						</li>
					</ul>
					</html>"));
	  
    equation
      vthDC = VTO + GAMMA * (sqrt(abs(PHI - vbsDC)) - sqrt(PHI));
      vthTran = VTO + GAMMA * (sqrt(abs(PHI - vbsTran)) - sqrt(PHI));
      vdsDC = noEvent(abs(Ids1.vDC));
      vdsDCSgn = Ids1.vDC;
      vdsTran = noEvent(abs(Cgs1.vTran - Cgd1.vTran));
      vdsTranSgn = Cgs1.vTran - Cgd1.vTran;
      vgsDC = max({Cgs1.vDC,Cgd1.vDC});
      vgsTran = max({Cgs1.vTran,Cgd1.vTran});
      vbsDC = max({Cbs.vDC,Cbd.vDC});
      vbsTran = max({Cbs.vTran,Cbd.vTran});
      gate_vAC_Re = g.vAC_Re;
      gate_vAC_Im = g.vAC_Im;
      bulk_vAC_Re = b.vAC_Re;
      bulk_vAC_Im = b.vAC_Im;
      (drain_vAC_mag,drain_vAC_phase) = Rect2Polar({d.vAC_Re,d.vAC_Im});
      drain_vAC_mag_dB = Decibels(drain_vAC_mag);
      (drain_iAC_mag,drain_iAC_phase) = Rect2Polar({d.iAC_Re,d.iAC_Im});
      drain_iAC_mag_dB = Decibels(drain_iAC_mag);
      (source_vAC_mag,source_vAC_phase) = Rect2Polar({s.vAC_Re,s.vAC_Im});
      source_vAC_mag_dB = Decibels(source_vAC_mag);
      (source_iAC_mag,source_iAC_phase) = Rect2Polar({s.iAC_Re,s.iAC_Im});
      source_iAC_mag_dB = Decibels(source_iAC_mag);
      (bulk_vAC_mag,bulk_vAC_phase) = Rect2Polar({b.vAC_Re,b.vAC_Im});
      bulk_vAC_mag_dB = Decibels(bulk_vAC_mag);
      (bulk_iAC_mag,bulk_iAC_phase) = Rect2Polar({b.iAC_Re,b.iAC_Im});
      bulk_iAC_mag_dB = Decibels(bulk_iAC_mag);
      (gate_vAC_mag,gate_vAC_phase) = Rect2Polar({g.vAC_Re,g.vAC_Im});
      gate_vAC_mag_dB = Decibels(gate_vAC_mag);
      (gate_iAC_mag,gate_iAC_phase) = Rect2Polar({g.iAC_Re,g.iAC_Im});
      gate_iAC_mag_dB = Decibels(gate_iAC_mag);
      connect(d,Ids1.p) annotation(points = [0,110;0,100.5;0,91;-6.73533e-16,91], style(color = 1));
      connect(Ids1.n,s) annotation(points = [6.73533e-16,-1;-6.73533e-16,-69], style(color = 1));
      connect(g,Cgd1.p) annotation(points = [-99,0;-80,0;-80,35;-61,35], style(color = 1));
      connect(g,Cgs1.p) annotation(points = [-99,0;-80,0;-80,-15;-61,-15], style(color = 1));
      connect(g,Cgb1.p) annotation(points = [-99,0;-80,0;-80,-55;-61,-55], style(color = 1));
      connect(b,Dbs.p) annotation(points = [97,1.34707e-15;80,0;80,-15;61,-15], style(color = 1));
      connect(b,Cbs.p) annotation(points = [97,1.34707e-15;80,0;80,-40;61,-40], style(color = 1));
      connect(b,Dbd.p) annotation(points = [97,1.34707e-15;80,0;80,35;61,35], style(color = 1));
      connect(b,Cbd.p) annotation(points = [97,1.34707e-15;80,0;80,60;61,60], style(color = 1));
      connect(b,Cgb1.n) annotation(points = [97,1.34707e-15;80,0;80,-55;-39,-55], style(color = 1));
      connect(Ids1.n,Cgs1.n) annotation(points = [6.73533e-16,-1;6.73533e-16,-15;-39,-15], style(color = 1));
      connect(Ids1.p,Cgd1.n) annotation(points = [-6.73533e-16,21;-6.73533e-16,35;-39,35], style(color = 1));
      connect(Ids1.n,Cbs.n) annotation(points = [29,-40;39,-40], style(color = 1));
      connect(Ids1.p,Cbd.n) annotation(points = [31,60;39,60], style(color = 1));
      connect(Cbd.n,Dbd.n) annotation(points = [39,60;39,53.5;38,53.5;38,47;39,47;39,35], style(color = 1));
      connect(Dbs.n,Cbs.n) annotation(points = [39,-15;39,-21.25;40,-21.25;40,-27.5;39,-27.5;39,-40], style(color = 1));
    end NMOStransistor;
	
 package NMOS "Contains the components used to model an NMOS transistor"
   extends Modelica.Icons.Library2;
   
   model Idiode	
    extends INTERFACE.OnePort;
	parameter SI.Current IS "Reverse saturation current at 300K";
	constant SI.Voltage thermalVolt = 300/11600 "Thermal voltage";
	constant SI.Conductance GMIN = 1e-12  "Conductance in parallel with the pn-junction";
	SI.Conductance gAC(start = 1) "AC small-signal conductance";
	
	equation
    iDC = IS * (exp(vDC / thermalVolt) - 1) + vDC * GMIN;
    iTran = if noEvent(vTran > 0) then IS * (exp(vTran / thermalVolt) - 1) + vTran * GMIN else (IS / thermalVolt + GMIN) * vTran;
	gAC = if vDC > 0 then IS / thermalVolt * exp(vDC / thermalVolt) + GMIN else IS / thermalVolt + GMIN;
	{iAC_Re,iAC_Im} = gAC * {vAC_Re,vAC_Im};
  end Idiode;
  
  model Ids
	extends INTERFACE.OnePort;
	outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vgsDC "Gate to source voltage";
	outer SI.Voltage vbsDC "Bulk to source voltage";
	outer SI.Voltage vdsDC "Drain to source voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vgsTran "Gate to source voltage";
	outer SI.Voltage vbsTran "Bulk to source voltage";
	outer SI.Voltage vdsTran "Drain to source voltage";
	outer SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";
	outer SI.Voltage gate_vAC_Re;
	outer SI.Voltage gate_vAC_Im;
	outer SI.Voltage bulk_vAC_Re;
	outer SI.Voltage bulk_vAC_Im;
	parameter SI.Voltage VTO "Zero-bias threshold voltage";
	parameter Real GAMMA "Body-effect parameter [V0.5]";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter Real KP "Transconductance parameter [A/V2]";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length LD "Lateral diffusion";
	parameter Real LAMBDA "Channel-length modulation [V-1]";
	protected 
	parameter Real beta = (KP * W) / (L - 2 * LD);
	Boolean pinNisSourceAC(start = true);
	SI.Current idsDC "Drain to source current";
	SI.Current idsTran "Drain to source current";
	Real ARG(start = 0);
	SI.Conductance gdsAC "dIds/dVds";
	SI.Conductance gmbsAC "dIds/dVbs";
	SI.Conductance gmAC "dIds/dVgs";
	SI.Voltage vdsAC_Re;
	SI.Voltage vdsAC_Im;
	SI.Voltage vgsAC_Re;
	SI.Voltage vgsAC_Im;
	SI.Voltage vbsAC_Re;
	SI.Voltage vbsAC_Im;
	SI.Current idsAC_Re;
	SI.Current idsAC_Im;

	equation
	 iDC = noEvent(if vDC > 0 then idsDC else -idsDC);
	 idsDC = if vgsDC <= vthDC then 0 
	         else noEvent(if vdsDC < vgsDC - vthDC then beta * (vgsDC - vthDC - 0.5 * vdsDC) * vdsDC * (1 + LAMBDA * vdsDC) 
			 else 0.5 * beta * (vgsDC - vthDC) ^ 2 * (1 + LAMBDA * vdsDC));
     iTran = if noEvent(vdsTranSgn >= 0) then idsTran 
	         else -idsTran;
     idsTran = if vgsTran <= vthTran then 0 
	           else if noEvent(vdsTran < vgsTran - vthTran) then beta * (vgsTran - vthTran - 0.5 * vdsTran) * vdsTran * (1 + LAMBDA * vdsTran) 
			   else 0.5 * beta * (vgsTran - vthTran) ^ 2 * (1 + LAMBDA * vdsTran);
	 {vdsAC_Re,vdsAC_Im} = if pinNisSourceAC then {vAC_Re,vAC_Im} else -{vAC_Re,vAC_Im};
	 {vgsAC_Re,vgsAC_Im} = if pinNisSourceAC then {gate_vAC_Re - n.vAC_Re,gate_vAC_Im - n.vAC_Im} else {gate_vAC_Re - p.vAC_Re,gate_vAC_Im - p.vAC_Im};
	 {vbsAC_Re,vbsAC_Im} = if pinNisSourceAC then {bulk_vAC_Re - n.vAC_Re,bulk_vAC_Im - n.vAC_Im} else {bulk_vAC_Re - p.vAC_Re,bulk_vAC_Im - p.vAC_Im};
	 {idsAC_Re,idsAC_Im} = gdsAC * {vdsAC_Re,vdsAC_Im} + gmbsAC * {vbsAC_Re,vbsAC_Im} + gmAC * {vgsAC_Re,vgsAC_Im};
	 {iAC_Re,iAC_Im} = if pinNisSourceAC then {idsAC_Re,idsAC_Im} else -{idsAC_Re,idsAC_Im};
	 pinNisSourceAC = vDC >= 0;
     gdsAC = if vgsDC <= vthDC then 0 
	         else if vdsDC < vgsDC - vthDC then beta * (vgsDC - vthDC - vdsDC) * (1 + LAMBDA * vdsDC) + beta * (vgsDC - vthDC - 0.5 * vdsDC) * LAMBDA * vdsDC 
			 else 0.5 * beta * (vgsDC - vthDC) ^ 2 * LAMBDA;
     gmbsAC = gmAC * ARG;
     ARG = if vbsDC > 0 then (0.5 * GAMMA) / (sqrt(PHI) - (0.5 * vbsDC) / sqrt(PHI)) 
	       else (0.5 * GAMMA) / sqrt(PHI - vbsDC);
     gmAC = if vgsDC <= vthDC then 0 
	        else if vdsDC < vgsDC - vthDC then beta * vdsDC * (1 + LAMBDA * vdsDC) 
			else beta * (vgsDC - vthDC) * (1 + LAMBDA * vdsDC);
	end Ids;
	
	partial model Capacitor
	extends INTERFACE.OnePort;
	outer SI.Frequency freq "Frequency of the source";
	constant Real pi = 3.14159265358979;
	SI.Capacitance Cvar(start = 1e-12) "Transient analysis capacitance";
	SI.Capacitance CvarAC(start = 1e-12) "AC small-signal capacitance";
	
	equation
	iDC = 0;
	{vAC_Re,vAC_Im} * 2 * pi * freq * CvarAC = {iAC_Im,-iAC_Re};
	end Capacitor;
	
	model Cdiode
	extends Capacitor;
	parameter Real CJ "Capacitance at zero-bias voltage per squere meter of area [F/m2]";
	parameter Real CJSW "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
	parameter Real MJ "Bulk junction capacitnce grading coefficient";
	parameter Real MJSW "Perimeter capacitance grading coefficient";
	parameter Real FC "Substrate-junction forward-bias coefficient";
	parameter SI.Voltage PB "Junction potencial";
	parameter SI.Length P "Junction perimeter";
	parameter SI.Area A "Junction area";
	protected 
	parameter Real F2 = (1 - FC) ^ (1 + MJ);
	parameter Real F3 = 1 - FC * (1 + MJ);
	parameter Real FCtimesPB = FC * PB;
	parameter Real CJtimesA = CJ * A;
	parameter Real CJSWtimesP = CJSW * P;
	parameter Real coef1 = F3 * (CJtimesA / F2 + (CJSW * P) / F2);
	parameter Real coef2 = ((CJtimesA * MJ) / F2 + (CJSW * P * MJSW) / F2) / PB;
	parameter Real invPB = 1 / PB;
	
	equation
	Cvar = if noEvent(vTran < FCtimesPB) then CJtimesA / (1 - invPB * vTran) ^ MJ + CJSWtimesP / (1 - invPB * vTran) ^ MJSW 
	       else coef1 + coef2 * vTran;
	Cvar * der(vTran) = iTran;
	CvarAC = if vDC < FCtimesPB then CJtimesA / (1 - invPB * vDC) ^ MJ + CJSWtimesP / (1 - invPB * vDC) ^ MJSW 
	         else coef1 + coef2 * vDC;
	end Cdiode;
	
	model Cgb
	extends Capacitor;
    outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vdsDC "Drain to source voltage";
	outer SI.Voltage vgsDC "Gate to source voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vdsTran "Drain to source voltage";
	outer SI.Voltage vgsTran "Gate to source voltage";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter SI.Length LD "Lateral diffusion";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length TOX "Gate oxide thickness";
	parameter Real EPSR "Dielectric constant of the oxide";
	parameter Real CGBO "Gate-bulk overlap capacitance per meter [F/m]";
	protected 
	parameter SI.Length LEFF = L + 2 * LD "Effective length";
	parameter SI.Capacitance COX = (EPS0 * EPSR * W * LEFF) / TOX "Gate oxide capacitance";
	parameter Real CGBOtimesLEFF = CGBO * LEFF;
	parameter Real COXtimesinvPHI = COX / PHI;
	constant Real EPS0 = 8.85e-12 "Permittivity of free space [F/m]";
	
	equation
	Cvar - CGBOtimesLEFF = if noEvent(vgsTran < vthTran - PHI) then COX 
	                       else if noEvent(vgsTran < vthTran) then COXtimesinvPHI * (vthTran - vgsTran) 
						   else 0;
	Cvar * der(vTran) = iTran;
	CvarAC = if vgsDC < vthDC - PHI then COX + CGBOtimesLEFF 
	         else if vgsDC < vthDC then COXtimesinvPHI * (vthDC - vgsDC) + CGBOtimesLEFF 
			 else CGBOtimesLEFF;
	end Cgb;
	
	model Cgd
	extends Capacitor;
	outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vdsDC "Drain to source voltage";
	outer SI.Voltage vdsDCSgn "Drain-pin to source-pin voltage";
	outer SI.Voltage vgsDC "Gate to source voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vdsTran "Drain to source voltage";
	outer SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";
	outer SI.Voltage vgsTran "Gate to source voltage";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter SI.Length LD "Lateral diffusion";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length TOX "Gate oxide thickness";
	parameter Real EPSR "Dielectric constant of the oxide";
	parameter Real CGDO "Gate-drain overlap capacitance per meter [F/m]";
	parameter Real CGSO "Gate-source overlap capacitance per meter [F/m]";
	parameter Boolean gateSourcePinsC;
	protected 
	parameter SI.Length LEFF = L + 2 * LD "Effective length";
	parameter SI.Capacitance COX = (EPS0 * EPSR * W * LEFF) / TOX "Gate oxide capacitance";
	constant Real EPS0 = 8.85e-12 "Permittivity of free space [F/m]";
	parameter Real CGSOtimesW = CGSO * W;
	parameter Real CGDOtimesW = CGDO * W;
	parameter Real twoThirdsCOX = 2 / 3 * COX;
	parameter Real threeFourthsCOX = (3 * COX) / 4;
	parameter Real halfCOX = 0.5 * COX;
	parameter SI.Voltage vdsTranEPS = 0.0001;
	parameter SI.Voltage vdsDCEPS = 0.0001;
	Real Cgs;
	Real Cgd;
	Real CgsAC;
	Real CgdAC;
	Real CpinsGS;
	Real CpinsGD;
	Real CpinsGSAC;
	Real CpinsGDAC;
	
	equation
	Cvar * der(vTran) = iTran;
	Cvar = if gateSourcePinsC then CpinsGS 
	       else CpinsGD;
	CpinsGS = if noEvent(vdsTranSgn < -vdsTranEPS) then Cgd 
	          else if noEvent(vdsTranSgn < vdsTranEPS) then (0.5 * (Cgs - Cgd) * vdsTranSgn) / vdsTranEPS + 0.5 * (Cgs + Cgd) 
			  else Cgs;
	CpinsGD = if noEvent(vdsTranSgn < -vdsTranEPS) then Cgs 
	          else if noEvent(vdsTranSgn < vdsTranEPS) then (0.5 * (Cgd - Cgs) * vdsTranSgn) / vdsTranEPS + 0.5 * (Cgs + Cgd) 
			  else Cgd;
	Cgs - CGSOtimesW = if noEvent(vgsTran <= vthTran - PHI) then 0 
	                   else if noEvent(vgsTran <= vthTran) then twoThirdsCOX * ((-vthTran + vgsTran) / PHI + 1) 
					   else if noEvent(vgsTran <= vthTran + vdsTran) then twoThirdsCOX 
					   else if noEvent(vdsTran <= 2 * vdsTranEPS) then halfCOX 
					   else twoThirdsCOX * (1 - ((vgsTran - vdsTran - vthTran) / (2 * (vgsTran - vthTran) - vdsTran)) ^ 2);
	Cgd - CGDOtimesW = if noEvent(vgsTran <= vthTran + vdsTran) then 0 
	                   else if noEvent(vdsTran <= 2 * vdsTranEPS) then threeFourthsCOX 
					   else COX * (1 - ((vgsTran - vthTran) / (2 * (vgsTran - vthTran) - vdsTran)) ^ 2);
	CvarAC = if gateSourcePinsC then CpinsGSAC 
	         else CpinsGDAC;
    CpinsGSAC = if noEvent(vdsDCSgn < -vdsDCEPS) then CgdAC 
	            else if noEvent(vdsDCSgn < vdsDCEPS) then (0.5 * (CgsAC - CgdAC) * vdsDCSgn) / vdsDCEPS + 0.5 * (CgsAC + CgdAC) 
				else CgsAC;
    CpinsGDAC = if noEvent(vdsDCSgn < -vdsDCEPS) then CgsAC 
	            else if noEvent(vdsDCSgn < vdsDCEPS) then (0.5 * (CgdAC - CgsAC) * vdsDCSgn) / vdsDCEPS + 0.5 * (CgsAC + CgdAC) 
				else CgdAC;
    CgsAC = if vgsDC <= vthDC - PHI then CGSOtimesW 
	        else if vgsDC <= vthDC then twoThirdsCOX * ((-vthDC + vgsDC) / PHI + 1) + CGSOtimesW 
			else if vgsDC <= vthDC + vdsDC then twoThirdsCOX + CGSOtimesW 
			else if vdsDC <= 2 * vdsDCEPS then halfCOX + CGSOtimesW 
			else twoThirdsCOX * (1 - ((vgsDC - vdsDC - vthDC) / (2 * (vgsDC - vthDC) - vdsDC)) ^ 2) + CGSOtimesW;
    CgdAC = if vgsDC <= vthDC + vdsDC then CGDOtimesW 
	        else if vdsDC <= 2 * vdsDCEPS then threeFourthsCOX + CGDOtimesW 
			else COX * (1 - ((vgsDC - vthDC) / (2 * (vgsDC - vthDC) - vdsDC)) ^ 2) + CGDOtimesW;
	end Cgd;
  
  annotation(Documentation(info = "<HTML>
<P>
This package contains different subcomponents necessary for creating NMOS transistors models.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
 end NMOS;
 
 
  model PMOStransistor "Spice Level 1 PMOS transistor model"
      extends INTERFACE.MOSFET;
      import Modelica.Electrical.IC.Constants.PMOStransistorConstants.*;
      inner SI.Voltage vsdDC "Source to drain voltage";
      inner SI.Voltage vsgDC "Source to gate voltage";
      inner SI.Voltage vsbDC "Source to bulk voltage";
      inner SI.Voltage vsdTran "Source to drain voltage";
      inner SI.Voltage vsgTran "Source to gate voltage";
      inner SI.Voltage vsbTran "Source to bulk voltage";
      SI.Voltage drain_vAC_mag "Magnitude of AC small-signal drain voltage";
      SI.Voltage drain_vAC_mag_dB "Magnitude (dB) of AC small-signal drain voltage";
      nonSI.Angle_deg drain_vAC_phase(start = 0) "Phase (deg) of AC small-signal drain voltage";
      SI.Voltage source_vAC_mag "Magnitude of AC small-signal source voltage";
      SI.Voltage source_vAC_mag_dB "Magnitude (dB) of AC small-signal source voltage";
      nonSI.Angle_deg source_vAC_phase(start = 0) "Phase (deg) of drain AC small-signal source voltage";
      SI.Voltage bulk_vAC_mag "Magnitude of AC small-signal bulk voltage";
      SI.Voltage bulk_vAC_mag_dB "Magnitude (dB) of AC small-signal bulk voltage";
      nonSI.Angle_deg bulk_vAC_phase(start = 0) "Phase (deg) of AC small-signal bulk voltage";
      SI.Voltage gate_vAC_mag "Magnitude of AC small-signal gate voltage";
      SI.Voltage gate_vAC_mag_dB "Magnitude (dB) of AC small-signal gate voltage";
      nonSI.Angle_deg gate_vAC_phase(start = 0) "Phase (deg) of AC small-signal gate voltage";
      SI.Current drain_iAC_mag "Magnitude of AC small-signal drain current";
      SI.Current drain_iAC_mag_dB "Magnitude (dB) of AC small-signal drain current";
      nonSI.Angle_deg drain_iAC_phase(start = 0) "Phase (deg) of AC small-signal drain current";
      SI.Current source_iAC_mag "Magnitude of AC small-signal source current";
      SI.Current source_iAC_mag_dB "Magnitude (dB) of AC small-signal source current";
      nonSI.Angle_deg source_iAC_phase(start = 0) "Phase (deg) of drain AC small-signal source current";
      SI.Current bulk_iAC_mag "Magnitude of AC small-signal bulk current";
      SI.Current bulk_iAC_mag_dB "Magnitude (dB) of AC small-signal bulk current";
      nonSI.Angle_deg bulk_iAC_phase(start = 0) "Phase (deg) of AC small-signal bulk current";
      SI.Current gate_iAC_mag "Magnitude of AC small-signal gate current";
      SI.Current gate_iAC_mag_dB "Magnitude (dB) of AC small-signal gate current";
      nonSI.Angle_deg gate_iAC_phase(start = 0) "Phase (deg) of AC small-signal gate current";
      parameter SI.Length L = 1e-7 "Gate length";
      parameter SI.Length W = 4e-6 "Gate width";
      inner SI.Voltage vsdDCSgn "Source-pin to drain-pin voltage";
      inner SI.Voltage vthDC "Threshold voltage";
      inner SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";
      inner SI.Voltage vthTran "Threshold voltage";
      inner SI.Voltage gate_vAC_Re;
      inner SI.Voltage gate_vAC_Im;
      inner SI.Voltage bulk_vAC_Re;
      inner SI.Voltage bulk_vAC_Im;
      PMOS.Isd Isd1(VTO = VTO, GAMMA = GAMMA, PHI = PHI, KP = KP, W = W, L = L, LD = LD, LAMBDA = LAMBDA) annotation(extent = [-10,-4;10,16], rotation = 90);
      PMOS.Idiode Dsb(IS = IS) annotation(extent = [48,-9;68,11], rotation = 0);
      PMOS.Cdiode Csb(CJ = CJ, CJSW = CJSW, MJ = MJ, MJSW = MJSW, FC = FC, PB = PB, P = PS, A = AS) annotation(extent = [40,-50;60,-30], rotation = 0);
      PMOS.Idiode Ddb(IS = IS) annotation(extent = [42,23;62,43], rotation = 0);
      PMOS.Cdiode Cdb(CJ = CJ, CJSW = CJSW, MJ = MJ, MJSW = MJSW, FC = FC, PB = PB, P = PD, A = AD) annotation(extent = [52,50;72,70], rotation = 0);
      PMOS.Cdg Cdg1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGDO = CGDO, CGSO = CGSO, sourceGatePinsC = false) annotation(extent = [-58,31;-38,51], rotation = 180);
      PMOS.Cdg Csg1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGDO = CGDO, CGSO = CGSO, sourceGatePinsC = true) annotation(extent = [-54,-25;-34,-5], rotation = 180);
      PMOS.Cbg Cbg1(PHI = PHI, LD = LD, W = W, L = L, TOX = TOX, EPSR = EPSR, CGBO = CGBO) annotation(extent = [-48,-69;-28,-49], rotation = 180);
      
	  annotation(Diagram(
				   graphics = {Polygon(points = {{60,-44.5},{60,-55},{41.5,-50},{60,-44.5}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25)}), 
				 Icon(
				   graphics = {Polygon(points = {{53.5,-42},{53.5,-54.5},{31.5,-48.5},{53.5,-42},{53.5,-42}}, rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, lineThickness = 0.25)}),
				 Documentation(info = "<HTML>
					<P>
					Model of an PMOS transistor.
					</P>
					</HTML>
					", revisions = "<html>
					<ul>
					<li><i> 2011   </i>
						by David Malo Cid
						</li>
					</ul>
					</html>"));
	  
    equation
      vthDC = VTO - GAMMA * (sqrt(abs(PHI - vsbDC)) - sqrt(PHI));
      vthTran = VTO - GAMMA * (sqrt(abs(PHI - vsbTran)) - sqrt(PHI));
      vsdDC = noEvent(abs(Isd1.vDC));
      vsdDCSgn = Isd1.vDC;
      vsdTran = noEvent(abs(Csg1.vTran - Cdg1.vTran));
      vsdTranSgn = Csg1.vTran - Cdg1.vTran;
      vsgDC = max({Csg1.vDC,Cdg1.vDC});
      vsgTran = max({Csg1.vTran,Cdg1.vTran});
      vsbDC = max({Csb.vDC,Cdb.vDC});
      vsbTran = max({Csb.vTran,Cdb.vTran});
      gate_vAC_Re = g.vAC_Re;
      gate_vAC_Im = g.vAC_Im;
      bulk_vAC_Re = b.vAC_Re;
      bulk_vAC_Im = b.vAC_Im;
      (drain_vAC_mag,drain_vAC_phase) = Rect2Polar({d.vAC_Re,d.vAC_Im});
      drain_vAC_mag_dB = Decibels(drain_vAC_mag);
      (drain_iAC_mag,drain_iAC_phase) = Rect2Polar({d.iAC_Re,d.iAC_Im});
      drain_iAC_mag_dB = Decibels(drain_iAC_mag);
      (source_vAC_mag,source_vAC_phase) = Rect2Polar({s.vAC_Re,s.vAC_Im});
      source_vAC_mag_dB = Decibels(source_vAC_mag);
      (source_iAC_mag,source_iAC_phase) = Rect2Polar({s.iAC_Re,s.iAC_Im});
      source_iAC_mag_dB = Decibels(source_iAC_mag);
      (bulk_vAC_mag,bulk_vAC_phase) = Rect2Polar({b.vAC_Re,b.vAC_Im});
      bulk_vAC_mag_dB = Decibels(bulk_vAC_mag);
      (bulk_iAC_mag,bulk_iAC_phase) = Rect2Polar({b.iAC_Re,b.iAC_Im});
      bulk_iAC_mag_dB = Decibels(bulk_iAC_mag);
      (gate_vAC_mag,gate_vAC_phase) = Rect2Polar({g.vAC_Re,g.vAC_Im});
      gate_vAC_mag_dB = Decibels(gate_vAC_mag);
      (gate_iAC_mag,gate_iAC_phase) = Rect2Polar({g.iAC_Re,g.iAC_Im});
      gate_iAC_mag_dB = Decibels(gate_iAC_mag);
      connect(d,Isd1.n) annotation(points = [0,110;0,100.5;0,91;-6.73533e-16,91], style(color = 1));
      connect(Isd1.p,s) annotation(points = [6.73533e-16,-1;-6.73533e-16,-69], style(color = 1));
      connect(g,Cdg1.n) annotation(points = [-99,0;-80,0;-80,35;-61,35], style(color = 1));
      connect(g,Csg1.n) annotation(points = [-99,0;-80,0;-80,-15;-61,-15], style(color = 1));
      connect(g,Cbg1.n) annotation(points = [-99,0;-80,0;-80,-55;-61,-55], style(color = 1));
      connect(b,Dsb.n) annotation(points = [97,1.34707e-15;80,0;80,-15;61,-15], style(color = 1));
      connect(b,Csb.n) annotation(points = [97,1.34707e-15;80,0;80,-40;61,-40], style(color = 1));
      connect(b,Ddb.n) annotation(points = [97,1.34707e-15;80,0;80,35;61,35], style(color = 1));
      connect(b,Cdb.n) annotation(points = [97,1.34707e-15;80,0;80,60;61,60], style(color = 1));
      connect(b,Cbg1.p) annotation(points = [97,1.34707e-15;80,0;80,-55;-39,-55], style(color = 1));
      connect(Isd1.p,Csg1.p) annotation(points = [6.73533e-16,-1;6.73533e-16,-15;-39,-15], style(color = 1));
      connect(Isd1.n,Cdg1.p) annotation(points = [-6.73533e-16,21;-6.73533e-16,35;-39,35], style(color = 1));
      connect(Isd1.p,Csb.p) annotation(points = [29,-40;39,-40], style(color = 1));
      connect(Isd1.n,Cdb.p) annotation(points = [31,60;39,60], style(color = 1));
      connect(Cdb.p,Ddb.p) annotation(points = [39,60;39,53.5;38,53.5;38,47;39,47;39,35], style(color = 1));
      connect(Dsb.p,Csb.p) annotation(points = [39,-15;39,-21.25;40,-21.25;40,-27.5;39,-27.5;39,-40], style(color = 1));
    end PMOStransistor;
 
 
 package PMOS "Contains the components used to model an PMOS transistor"
   extends Modelica.Icons.Library2;
   
   model Idiode	
    extends INTERFACE.OnePort;
	parameter SI.Current IS "Reverse saturation current at 300K";
	constant SI.Voltage thermalVolt = 300/11600 "Thermal voltage";
	constant SI.Conductance GMIN = 1e-12  "Conductance in parallel with the pn-junction";
	SI.Conductance gAC(start = 1) "AC small-signal conductance";
	
	equation
    iDC = IS * (exp(vDC / thermalVolt) - 1) + vDC * GMIN;
    iTran = if noEvent(vTran > 0) then IS * (exp(vTran / thermalVolt) - 1) + vTran * GMIN else (IS / thermalVolt + GMIN) * vTran;
	gAC = if vDC > 0 then IS / thermalVolt * exp(vDC / thermalVolt) + GMIN else IS / thermalVolt + GMIN;
	{iAC_Re,iAC_Im} = gAC * {vAC_Re,vAC_Im};
  end Idiode;
  
  model Isd
	extends INTERFACE.OnePort;
	outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vsgDC "Source to gate voltage";
	outer SI.Voltage vsbDC "Source to bulk voltage";
	outer SI.Voltage vsdDC "Source to drain voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vsgTran "Source to gate voltage";
	outer SI.Voltage vsbTran "Source to bulk voltage";
	outer SI.Voltage vsdTran "Source to drain voltage";
	outer SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";
	outer SI.Voltage gate_vAC_Re;
	outer SI.Voltage gate_vAC_Im;
	outer SI.Voltage bulk_vAC_Re;
	outer SI.Voltage bulk_vAC_Im;
	parameter SI.Voltage VTO "Zero-bias threshold voltage";
	parameter Real GAMMA "Body-effect parameter [V0.5]";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter Real KP "Transconductance parameter [A/V2]";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length LD "Lateral diffusion";
	parameter Real LAMBDA "Channel-length modulation [V-1]";
	protected 
	parameter Real beta = (KP * W) / (L - 2 * LD);
	Boolean pinPisSourceAC(start = true);
	SI.Current isdDC "Source to drain current";
	SI.Current isdTran "Source to drain current";
	Real ARG(start = 0);
	SI.Conductance gsdAC "dIsd/dVsd";
	SI.Conductance gmbsAC "dIsd/dVsb";
	SI.Conductance gmAC "dIsd/dVsg";
	SI.Voltage vsdAC_Re;
	SI.Voltage vsdAC_Im;
	SI.Voltage vsgAC_Re;
	SI.Voltage vsgAC_Im;
	SI.Voltage vsbAC_Re;
	SI.Voltage vsbAC_Im;
	SI.Current isdAC_Re;
	SI.Current isdAC_Im;

	equation
	 iDC = noEvent(if vDC > 0 then isdDC else -isdDC);
	 isdDC = if vsgDC <= -vthDC then 0 
	         else noEvent(if vsdDC < vsgDC + vthDC then beta * (vsgDC + vthDC - 0.5 * vsdDC) * vsdDC * (1 + LAMBDA * vsdDC) 
			 else 0.5 * beta * (vsgDC + vthDC) ^ 2 * (1 + LAMBDA * vsdDC));
     iTran = if noEvent(vsdTranSgn >= 0) then isdTran 
	         else -isdTran;
     isdTran = if vsgTran <= -vthTran then 0 
	           else if noEvent(vsdTran < vsgTran + vthTran) then beta * (vsgTran + vthTran - 0.5 * vsdTran) * vsdTran * (1 + LAMBDA * vsdTran) 
			   else 0.5 * beta * (vsgTran + vthTran) ^ 2 * (1 + LAMBDA * vsdTran);
	 {vsdAC_Re,vsdAC_Im} = if pinPisSourceAC then {vAC_Re,vAC_Im} else -{vAC_Re,vAC_Im};
	 {vsgAC_Re,vsgAC_Im} = if pinPisSourceAC then -{gate_vAC_Re - p.vAC_Re,gate_vAC_Im - p.vAC_Im} else -{gate_vAC_Re - n.vAC_Re,gate_vAC_Im - n.vAC_Im};
	 {vsbAC_Re,vsbAC_Im} = if pinPisSourceAC then -{bulk_vAC_Re - p.vAC_Re,bulk_vAC_Im - p.vAC_Im} else -{bulk_vAC_Re - n.vAC_Re,bulk_vAC_Im - n.vAC_Im};
	 {isdAC_Re,isdAC_Im} = gsdAC * {vsdAC_Re,vsdAC_Im} + gmbsAC * {vsbAC_Re,vsbAC_Im} + gmAC * {vsgAC_Re,vsgAC_Im};
	 {iAC_Re,iAC_Im} = if pinPisSourceAC then {isdAC_Re,isdAC_Im} else -{isdAC_Re,isdAC_Im};
	 pinPisSourceAC = vDC >= 0;
     gsdAC = if vsgDC <= -vthDC then 0 
	         else if vsdDC < vsgDC + vthDC then beta * (vsgDC + vthDC - vsdDC) * (1 + LAMBDA * vsdDC) + beta * (vsgDC + vthDC - 0.5 * vsdDC) * LAMBDA * vsdDC 
			 else 0.5 * beta * (vsgDC + vthDC) ^ 2 * LAMBDA;
     gmbsAC = gmAC * ARG;
     ARG = if vsbDC > 0 then (0.5 * GAMMA) / (sqrt(PHI) - (0.5 * vsbDC) / sqrt(PHI)) 
	       else (0.5 * GAMMA) / sqrt(PHI - vsbDC);
     gmAC = if vsgDC <= -vthDC then 0 
	        else if vsdDC < vsgDC + vthDC then beta * vsdDC * (1 + LAMBDA * vsdDC) 
			else beta * (vsgDC + vthDC) * (1 + LAMBDA * vsdDC);
	end Isd;
	
	partial model Capacitor
	extends INTERFACE.OnePort;
	constant Real pi = 3.14159265358979;
	outer SI.Frequency freq "Frequency of the source";
	SI.Capacitance Cvar(start = 1e-12) "Transient analysis capacitance";
	SI.Capacitance CvarAC(start = 1e-12) "AC small-signal capacitance";
	
	equation
	iDC = 0;
	{vAC_Re,vAC_Im} * 2 * pi * freq * CvarAC = {iAC_Im,-iAC_Re};
	end Capacitor;
	
	model Cdiode
	extends Capacitor;
	parameter Real CJ "Capacitance at zero-bias voltage per squere meter of area [F/m2]";
	parameter Real CJSW "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
	parameter Real MJ "Bulk junction capacitnce grading coefficient";
	parameter Real MJSW "Perimeter capacitance grading coefficient";
	parameter Real FC "Substrate-junction forward-bias coefficient";
	parameter SI.Voltage PB "Junction potencial";
	parameter SI.Length P "Junction perimeter";
	parameter SI.Area A "Junction area";
	protected 
	parameter Real F2 = (1 - FC) ^ (1 + MJ);
	parameter Real F3 = 1 - FC * (1 + MJ);
	parameter Real FCtimesPB = FC * PB;
	parameter Real CJtimesA = CJ * A;
	parameter Real CJSWtimesP = CJSW * P;
	parameter Real coef1 = F3 * (CJtimesA / F2 + (CJSW * P) / F2);
	parameter Real coef2 = ((CJtimesA * MJ) / F2 + (CJSW * P * MJSW) / F2) / PB;
	parameter Real invPB = 1 / PB;
	
	equation
	Cvar = if noEvent(vTran < FCtimesPB) then CJtimesA / (1 - invPB * vTran) ^ MJ + CJSWtimesP / (1 - invPB * vTran) ^ MJSW 
	       else coef1 + coef2 * vTran;
	Cvar * der(vTran) = iTran;
	CvarAC = if vDC < FCtimesPB then CJtimesA / (1 - invPB * vDC) ^ MJ + CJSWtimesP / (1 - invPB * vDC) ^ MJSW 
	         else coef1 + coef2 * vDC;
	end Cdiode;
	
	model Cbg
	extends Capacitor;
    outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vsdDC "Source to drain voltage";
	outer SI.Voltage vsgDC "Source to gate voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vsdTran "Source to drain voltage";
	outer SI.Voltage vsgTran "Source to gate voltage";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter SI.Length LD "Lateral diffusion";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length TOX "Gate oxide thickness";
	parameter Real EPSR "Dielectric constant of the oxide";
	parameter Real CGBO "Gate-bulk overlap capacitance per meter [F/m]";
	protected 
	parameter SI.Length LEFF = L + 2 * LD "Effective length";
	parameter SI.Capacitance COX = (EPS0 * EPSR * W * LEFF) / TOX "Gate oxide capacitance";
	parameter Real CGBOtimesLEFF = CGBO * LEFF;
	parameter Real COXtimesinvPHI = COX / PHI;
	constant Real EPS0 = 8.85e-12 "Permittivity of free space [F/m]";
	
	equation
	Cvar - CGBOtimesLEFF = if noEvent(vsgTran < -vthTran - PHI) then COX 
	                       else if noEvent(vsgTran < -vthTran) then COXtimesinvPHI * (-vthTran - vsgTran) 
						   else 0;
	Cvar * der(vTran) = iTran;
	CvarAC = if vsgDC < - vthDC - PHI then COX + CGBOtimesLEFF 
	         else if vsgDC < -vthDC then COXtimesinvPHI * (-vthDC - vsgDC) + CGBOtimesLEFF 
			 else CGBOtimesLEFF;
	end Cbg;
	
	model Cdg
	extends Capacitor;
	outer SI.Voltage vthDC "Threshold voltage";
	outer SI.Voltage vsdDC "Source to drain voltage";
	outer SI.Voltage vsdDCSgn "Source-pin to drain-pin voltage";
	outer SI.Voltage vsgDC "Source to gain voltage";
	outer SI.Voltage vthTran "Threshold voltage";
	outer SI.Voltage vsdTran "Source to drain voltage";
	outer SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";
	outer SI.Voltage vsgTran "Source to gate voltage";
	parameter SI.Voltage PHI "Surface inversion potencial";
	parameter SI.Length LD "Lateral diffusion";
	parameter SI.Length W "Gate width";
	parameter SI.Length L "Gate length";
	parameter SI.Length TOX "Gate oxide thickness";
	parameter Real EPSR "Dielectric constant of the oxide";
	parameter Real CGDO "Gate-drain overlap capacitance per meter [F/m]";
	parameter Real CGSO "Gate-source overlap capacitance per meter [F/m]";
	parameter Boolean sourceGatePinsC;
	protected 
	parameter SI.Length LEFF = L + 2 * LD "Effective length";
	parameter SI.Capacitance COX = (EPS0 * EPSR * W * LEFF) / TOX "Gate oxide capacitance";
	constant Real EPS0 = 8.85e-12 "Permittivity of free space [F/m]";
	parameter Real CGSOtimesW = CGSO * W;
	parameter Real CGDOtimesW = CGDO * W;
	parameter Real twoThirdsCOX = 2 / 3 * COX;
	parameter Real threeFourthsCOX = 3 / 4 * COX;
	parameter Real halfCOX = 0.5 * COX;
	parameter SI.Voltage vsdTranEPS = 0.0001;
	parameter SI.Voltage vsdDCEPS = 0.0001;
	Real Csg;
	Real Cdg;
	Real CsgAC;
	Real CdgAC;
	Real CpinsSG;
	Real CpinsDG;
	Real CpinsSGAC;
	Real CpinsDGAC;
	
	equation
	Cvar * der(vTran) = iTran;
	Cvar = if sourceGatePinsC then CpinsSG 
	       else CpinsDG;
	CpinsSG = if noEvent(vsdTranSgn < -vsdTranEPS) then Cdg 
	          else if noEvent(vsdTranSgn < vsdTranEPS) then (0.5 * (Csg - Cdg) * vsdTranSgn) / vsdTranEPS + 0.5 * (Csg + Cdg) 
			  else Csg;
	CpinsDG = if noEvent(vsdTranSgn < -vsdTranEPS) then Csg 
	          else if noEvent(vsdTranSgn < vsdTranEPS) then (0.5 * (Cdg - Csg) * vsdTranSgn) / vsdTranEPS + 0.5 * (Csg + Cdg) 
			  else Cdg;
	Csg - CGSOtimesW = if noEvent(vsgTran <= -vthTran - PHI) then 0 
	                   else if noEvent(vsgTran <= -vthTran) then twoThirdsCOX * ((vthTran + vsgTran) / PHI + 1) 
					   else if noEvent(vsgTran <= vthTran + vsdTran) then twoThirdsCOX 
					   else if noEvent(vsdTran <= 2 * vsdTranEPS) then halfCOX 
					   else twoThirdsCOX * (1 - ((vsgTran - vsdTran + vthTran) / (2 * (vsgTran + vthTran) - vsdTran)) ^ 2);
	Cdg - CGDOtimesW = if noEvent(vsgTran <= -vthTran + vsdTran) then 0 
	                   else if noEvent(vsdTran <= 2 * vsdTranEPS) then threeFourthsCOX 
					   else COX * (1 - ((vsgTran + vthTran) / (2 * (vsgTran + vthTran) - vsdTran)) ^ 2);
	CvarAC = if sourceGatePinsC then CpinsSGAC 
	         else CpinsDGAC;
    CpinsSGAC = if noEvent(vsdDCSgn < -vsdDCEPS) then CdgAC 
	            else if noEvent(vsdDCSgn < vsdDCEPS) then (0.5 * (CsgAC - CdgAC) * vsdDCSgn) / vsdDCEPS + 0.5 * (CsgAC + CdgAC) 
				else CsgAC;
    CpinsDGAC = if noEvent(vsdDCSgn < -vsdDCEPS) then CsgAC 
	            else if noEvent(vsdDCSgn < vsdDCEPS) then (0.5 * (CdgAC - CsgAC) * vsdDCSgn) / vsdDCEPS + 0.5 * (CsgAC + CdgAC) 
				else CdgAC;
    CsgAC = if vsgDC <= -vthDC - PHI then CGSOtimesW 
	        else if vsgDC <= -vthDC then twoThirdsCOX * ((vthDC + vsgDC) / PHI + 1) + CGSOtimesW 
			else if vsgDC <= -vthDC + vsdDC then twoThirdsCOX + CGSOtimesW 
			else if vsdDC <= 2 * vsdDCEPS then halfCOX + CGSOtimesW 
			else twoThirdsCOX * (1 - ((vsgDC - vsdDC + vthDC) / (2 * (vsgDC + vthDC) - vsdDC)) ^ 2) + CGSOtimesW;
    CdgAC = if vsgDC <= -vthDC + vsdDC then CGDOtimesW 
	        else if vsdDC <= 2 * vsdDCEPS then threeFourthsCOX + CGDOtimesW 
			else COX * (1 - ((vsgDC + vthDC) / (2 * (vsgDC + vthDC) - vsdDC)) ^ 2) + CGDOtimesW;
	end Cdg;
 
 annotation(Documentation(info = "<HTML>
<P>
This package contains different subcomponents necessary for creating PMOS transistors models.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
 end PMOS;
 

 annotation(Documentation(info = "<HTML>
<P>
This package contains different components used for IC design:
<ul>
<li>Resistor</li>
<li>Capacitor</li>
<li>NMOS Transistor</li>
<li>PMOS Transistor</li>
</ul>
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
end Components;