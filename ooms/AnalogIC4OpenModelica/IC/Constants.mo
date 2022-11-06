within Modelica.Electrical.IC;

package Constants "Contains constants and fabrication parameters for different components"
    extends Modelica.Icons.Library2;
    import SI = Modelica.SIunits;
	
    package ResistorConstants "Contains constants and parameters for resistor"
      final constant SI.Resistance Rs = 50 "Sheet resistance of the resistor material";
	  
	  annotation(Documentation(info = "<HTML>
		<P>
		Constants and parameters for resistors.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
    end ResistorConstants;
	
    package CapacitorConstants "Contains constants and parameters for capacitor"
      final constant Real pi = 2 * Modelica.Math.asin(1.0);
      final constant Real Er = 3.4 "relative permittivity of capacitor dielectric";
      final constant SI.Distance t = 500e-10 "Separation of capacitor metal plates";
	  
	  annotation(Documentation(info = "<HTML>
		<P>
		Constants and parameters for capacitors.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
    end CapacitorConstants;
	
	package InductorConstants "Contains constants and parameters for inductor"
      final constant Real pi = 2 * Modelica.Math.asin(1.0);
	  
	  annotation(Documentation(info = "<HTML>
		<P>
		Constants and parameters for inductors.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
    end InductorConstants;
	
    package NMOStransistorConstants "Contains constants and parameters for NMOS transistor"
	   constant SI.Area AD = 0 "drain difussion area";
   	   constant SI.Area AS = 0 "Source difussion area";
       constant SI.Permittivity CGBO = 3e-10 "Gate-bulk overlap capacitance per meter [F/m]";
       constant SI.Permittivity CGDO = 3e-10 "Gate-drain overlap capacitance per meter [F/m]";
       constant SI.Permittivity CGSO = 3e-10 "Gate-source overlap capacitance per meter [F/m]";
       constant Real CJ = 0.0001 "Capacitance at zero-bias voltage per square meter of area [F/m2]";
       constant SI.Permittivity CJSW = 5e-10 "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
       constant Real FC = 0.5 "Substrate-junction forward-bias coefficient";
       constant Real GAMMA = 0.4675 "Body-effect parameter [V0.5]";
       constant SI.Current IS = 1e-14 "Reverse saturation current at 300K";
       constant Real KP = 5e-05 "Transconductance parameter [A/V2]";
	   constant Real LAMBDA = 3.3e-02 "Channel-length modulation [V-1]";
       constant SI.Length LD = 0 "Lateral diffusion";
       constant Real MJ = 0.75 "Bulk junction capacitnce grading coefficient";
       constant Real MJSW = 0.33 "Perimeter capacitance grading coefficient";
       constant SI.Length PD = 0.0004 "drain difussion perimeter";
       constant SI.Length PS = 0.0004 "source difussion perimeter";
       constant SI.Voltage PB = 0.95 "Junction potencial";
       constant SI.Voltage PHI = 0.6 "Surface inversion potencial";
	   constant SI.Length TOX = 4.2e-08 "Gate oxide thickness";
       constant SI.Voltage VTO = 0.43 "Zero-bias threshold voltage";
	   constant Real EPSR = 3.9 "Dielectric constant of the oxide";
	   
	   annotation(Documentation(info = "<HTML>
		<P>
		Constants and parameters for NMOS transistor.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
    end NMOStransistorConstants;
	
	package PMOStransistorConstants "Contains constants and parameters for NMOS transistor"
	   constant SI.Area AD = 0 "drain difussion area";
   	   constant SI.Area AS = 0 "Source difussion area";
       constant SI.Permittivity CGBO = 3e-10 "Gate-bulk overlap capacitance per meter [F/m]";
       constant SI.Permittivity CGDO = 3e-10 "Gate-drain overlap capacitance per meter [F/m]";
       constant SI.Permittivity CGSO = 3e-10 "Gate-source overlap capacitance per meter [F/m]";
       constant Real CJ = 0.0001 "Capacitance at zero-bias voltage per square meter of area [F/m2]";
       constant SI.Permittivity CJSW = 5e-10 "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
       constant Real FC = 0.5 "Substrate-junction forward-bias coefficient";
       constant Real GAMMA = 0.4675 "Body-effect parameter [V0.5]";
       constant SI.Current IS = 1e-14 "Reverse saturation current at 300K";
       constant Real KP = 5e-05 "Transconductance parameter [A/V2]";
	   constant Real LAMBDA = 3.3e-02 "Channel-length modulation [V-1]";
       constant SI.Length LD = 0 "Lateral diffusion";
       constant Real MJ = 0.75 "Bulk junction capacitnce grading coefficient";
       constant Real MJSW = 0.33 "Perimeter capacitance grading coefficient";
       constant SI.Length PD = 0.0004 "drain difussion perimeter";
       constant SI.Length PS = 0.0004 "source difussion perimeter";
       constant SI.Voltage PB = 0.95 "Junction potencial";
       constant SI.Voltage PHI = 0.6 "Surface inversion potencial";
	   constant SI.Length TOX = 4.2e-08 "Gate oxide thickness";
       constant SI.Voltage VTO = -0.43 "Zero-bias threshold voltage";
	   constant Real EPSR = 3.9 "Dielectric constant of the oxide";
	   
	   annotation(Documentation(info = "<HTML>
		<P>
		Constants and parameters for PMOS transistors.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
    end PMOStransistorConstants;
	
	
    annotation(Documentation(info = "<HTML>
<P>
This package contains usefull constants and fabrication parameters that are used in different components.
This parameters should be adjusted to each manufacturer own parameters.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
  end Constants;
