model PI
  parameter Real CSmax=1;
  parameter Real CSmin=0;
  parameter Real k=0.7;
  parameter Real Ti=280;
  parameter Real b=0;
  Real SPf;
  Real xRff;
  Real fbOut;

public
  Modelica.Blocks.Interfaces.RealInput PV;
equation
  CS = max(CSmin, min(CSmax, k*(SPf-PV) + fbOut));
  Ti*der(fbOut)+fbOut= CS;
  Ti*der(xRff)+xRff = (1-b)*SP;
  SPf = b*SP+xRff;

public
  Modelica.Blocks.Interfaces.RealInput SP;
  Modelica.Blocks.Interfaces.RealOutput CS;

initial equation
  SPf = SP;
end PI;

model digital2dofPID_TDO
  parameter Real K = 1 "Gain";
  parameter Real Ti = 10 "Integral time [s]";
  parameter Real Td = 0 "Derivative time [s]";
  parameter Real N = 5 "Derivative filter ratio [#]";
  parameter Real b = 1 "SP weight in P action [#]";
  parameter Real c = 0 "SP weight in D action [#]";
  parameter Real CSmax = 100 "Maximum CS";
  parameter Real CSmin = 0 "Minimum CS";
  parameter Real TDsteps = 100 "TDO resolution";
  parameter Real Ts = 0.1 "Sampling time [s]";
  Real counter;

//protected
  Real sp;
  Real spo;
  Real dsp;
  Real pv;
  Real pvo;
  Real dpv;
  Real dp;
  Real di;
  Real d;
  Real dold;
  Real dd;
  Real cs;
  Real cso;
  Real dcs;
  Real StepsUp;
public
  input Modelica.Blocks.Interfaces.RealInput SP;
  input Modelica.Blocks.Interfaces.RealInput PV;
  output Modelica.Blocks.Interfaces.RealOutput CS;
  Modelica.Blocks.Interfaces.RealInput TR;
  Modelica.Blocks.Interfaces.BooleanInput TS;

algorithm
  when sample(0,Ts/TDsteps) then
    counter := counter+Ts/TDsteps;
    if counter>=Ts then
    // Compute control signal
    counter :=0;
    sp := SP;
    pv := PV;
    dsp := sp-spo;
    dpv := pv-pvo;
    if not TS then
      dp := K*(b*dsp-dpv);
      di := K*Ts/Ti*(sp-pv);
      d := (Td*pre(d)+K*N*Td*(c*dsp-dpv))
           /(if Td>0 then Td+N*Ts else 1);
      dd := d-dold;
      dcs := dp+di+dd;
      cs := cso + dcs;
      else
        cs := pre(TR);
      end if;
      if cs>CSmax then
        cs:=CSmax;
      end if;
      if cs<CSmin
      then
        cs:=CSmin;
      end if;
      spo := sp;
      pvo := pv;
      cso := cs;
      dold := d;
      StepsUp := floor((cs-CSmin)/(CSmax-CSmin)*Ts);
    end if;
    CS := if (counter<StepsUp) then CSmax
      else CSmin;
  end when;
end digital2dofPID_TDO;
