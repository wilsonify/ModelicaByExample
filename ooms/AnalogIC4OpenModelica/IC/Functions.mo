within Modelica.Electrical.IC;

package Functions "Contains functions for units and coordinates translation"
extends Modelica.Icons.Library2;
import SI = Modelica.SIunits;
import nonSI = Modelica.SIunits.Conversions.NonSIunits;
import Modelica.Math;

function Rect2Polar 
   input  Real             rect[2];
   output Real             module;
   output nonSI.Angle_deg  angle;
protected 
   SI.Angle       angFirst;
   constant  Real pi = 3.14159265358979;
algorithm
   module := sqrt ( rect * rect );
   angFirst := if not module > 0 
               then 0 
               else Math.asin( abs(rect[2]) / module );
   angle := if rect[1] <0 
            then pi - angFirst 
            else angFirst;
   angle := if rect[2] < 0
            then - angle
            else   angle;
   angle := 180 * angle / pi;
   
   annotation(Documentation(info = "<HTML>
		<P>
		Function to convert from x-y coordinates system to module-angle system
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
end Rect2Polar;

function Decibels
   input  Real x;
   output Real x_dB;
algorithm
   x_dB := 20 * Math.log10( x );
   
   annotation(Documentation(info = "<HTML>
		<P>
		Function to convert a variable value to decibels.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
end Decibels;

function Rad2Deg
   input  SI.Angle        angle_rad;
   output nonSI.Angle_deg angle_deg;
protected
   constant   Real  pi = 3.14159265358979;
algorithm
   angle_deg := 180 * angle_rad / pi;
   
   annotation(Documentation(info = "<HTML>
		<P>
		Function to covert from radians to decimal angles.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
end Rad2Deg;

function Deg2Rad
   input  nonSI.Angle_deg angle_deg;
   output SI.Angle        angle_rad;
protected
   constant   Real  pi = 3.14159265358979;
algorithm
   angle_rad := pi * angle_deg / 180;
   
   annotation(Documentation(info = "<HTML>
		<P>
		Function to convert from decimal angles to radians.
		</P>
		</HTML>
		", revisions = "<html>
		<ul>
		<li><i> 2011   </i>
			by David Malo Cid
			</li>

		</ul>
		</html>"));
end Deg2Rad;

annotation(Documentation(info = "<HTML>
<P>
This package contains usefull functions for calculating components variables.
</P>
</HTML>
", revisions = "<html>
<ul>
<li><i> 2011   </i>
       by David Malo Cid
       </li>

</ul>
</html>"));
end Functions;
