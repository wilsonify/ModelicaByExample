model DACSRealTimeSynchronization "a model which can be extended to any other models to run in realtime"
  Real outputValue ;
  Modelica.SIunits.Time realTime ;
  Modelica.SIunits.Time simulationTime ;
  Real simulationSpeed ;
  annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
  function initTime "Initializes the hardware timer on mainboard"
    input Modelica.SIunits.Time iTime ;
    output Real p ;
    annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));

    external  p = initTime(iTime)     annotation(Library = "libTimerFunction.o", Include = "#include \"TimerFunction.h\"");
  end initTime ;
  function getRealTime "returns the current hardware timer value of mainboard"
    input Modelica.SIunits.Time sTime ;
    output Real y ;

    external  y = getRealTime(sTime)     annotation(Library = "libTimerFunction.o", Include = "#include \"TimerFunction.h\"");
  end getRealTime ;
  function controlSimulation "a function which controls the execution of the system"
    input Modelica.SIunits.Time rTime ;
    input Modelica.SIunits.Time oRealTime ;
    input Modelica.SIunits.Time simTime ;
    input Modelica.SIunits.Time oSimulationTime ;
    output Real sSpeed = 1.0 ;
  algorithm 
    while (simTime > rTime or sSpeed > 1.1) loop
          rTime:=getRealTime(simTime);
      sSpeed:=(simTime - oSimulationTime) / (rTime - oRealTime);

    end while;
  end controlSimulation ;
protected 
  Modelica.SIunits.Time oldRealTime ;
  Modelica.SIunits.Time oldSimulationTime ;
algorithm 
  when sample(0, 0.5) then
      oldSimulationTime:=time;
    oldRealTime:=getRealTime(time);
  
  end when;
  realTime:=getRealTime(time);
  simulationTime:=time;
  simulationSpeed:=(time - oldSimulationTime) / (realTime - oldRealTime);
  outputValue:=controlSimulation(realTime, oldRealTime, time, oldSimulationTime);
end DACSRealTimeSynchronization;

