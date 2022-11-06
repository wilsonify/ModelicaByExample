model OneTankSystem
  extends Tanksystem.Onetanksystem ;
  extends DACSRealTimeSynchronization ;
  Real initValue ;
  annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
algorithm 
  if initial() then 
    initValue:=initTime(time);

  else 
  end if;
end OneTankSystem;

