//--- energy balances --------------------------------
Cmash*der(Tm) = Qmash_air + Qmash_tank + Qreact;
Cmash = Mwater*CpWater + Mgrains*CpMalt;
Qmash_air = Umash_air*SupArea*(Te - Tm);
Qmash_tank = -Qbp-Qbb;
Clat*der(Tlat) = Qbp + Qpe + Qbap;
Clat = CpMetal*MvessLat;
Qbp = LatArea *Umash_tank*(Tm - Tlat);
Qpe = LatArea *Utank_outside*(Te - Tlat);
Qbap = (pi*radO^2-pi*radI^2)*lambda_m/Lrifbp*(Tbase-Tlat);
Cbase*der(Tbase) = Qbb + Qbe + Q_gasburner - Qbap;
Cbase= CpMetal*MvessBase;
Qbb=SupArea*Umash_tank*(Tm - Tbase);
Qbe=SupArea*Utank_outside*(Te - Tbase);
radO=radI+LatThick;
volume = radI^2*pi*level;
volume = Mwater/densWater + Mmalt/densMalto;
ContactArea = pi*radI^2 + level*radI*2*pi;
SupArea = radI^2*pi;
LatArea =level*radI*2*pi;
MvessLat=2*radI*pi*H*LatThick *densMetal;
MvessBase=radI^2*pi*BaseThick *densMetal;

