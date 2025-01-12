//--- reaction powers --------------------------------Qreact = Qglu + Qmal + Qmlt;
Qglu = -((Rgl + R1gl)*Mgrains)*Hglu;
Hglu = H0glu/mmGlu + Cglu*(Tm - T0);
H0glu = HfGlu - HfWater - HfStarch;
Cglu = CpGlu - CpStarch - CpWater;
Qmal = -((Rmal + R1mal)*Mgrains)*Hmal;
Hmal = H0mal/mmMal + Cmal*(Tm - T0);
H0mal = HfMal/2 - HfWater/2 - HfStarch;
Cmal = CpMal/2 - CpStarch - CpWater/2;
Qmlt = -((Rmlt + R1mlt)*Mgrains)*Hmlt;
Hmlt = H0mlt/mmMlt + Cmlt*(Tm - T0);
H0mlt = HfMlt/3 - HfWater/3 - HfStarch;
Cmlt = CpMlt/3 - CpStarch - CpWater/3;
