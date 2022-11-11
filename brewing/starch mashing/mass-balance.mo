//--- mass balances ----------------------------------
M = Mwater + Mmalt;
Mmalt = Mcarbo + Mother;
Mcarbo = Mglu + Mmal + Mmlt + MstarchGel+ MstarchNG + Mdex;
Mother = ((1 - AmIni - GluIni - MalIni - MltIni- DexIni)*Mgrains);
Mglu = Mgrains*glu;
Mmal = Mgrains*mal;
Mmlt = Mgrains*mlt;
MstarchGel = Mgrains*Sg;
MstarchNG = Mgrains*Ss;
Mdex = Mgrains*D;
TotProd = glu + mal + mlt + D - GluIni - MalIni- MltIni - DexIni;