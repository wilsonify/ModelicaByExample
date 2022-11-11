//--- enzymatic activities ---------------------------
RdeAlfa = KdeAlfa*exp(-EdeAlfa/(R*Tm))*Ealfa;
RdeBeta = KdeBeta*exp(-EdeBeta/(R*Tm))*Ebeta;
RealActAlfa = aalfa*Ealfa;
RealActBeta = abeta*Ebeta;
aalfa = if aalfa < 0 then 0else if Tm < 315 then 1else 1.3333333e-07*(Tm -300)^6 - 2.2e-05*(Tm - 300)^5+ 0.00144333333333*(Tm - 300)^4- 0.0490499999999 *(Tm - 300)^3+ 0.92383333333122*(Tm - 300)^2- 8.89999999997759*(Tm - 300)+ 34.299999999904;
abeta = if abeta < 0 then 0else if Tm < 304 then 1else if Tm >= 304 and Tm < 336then 0.049*Tm - 13.9else if Tm >= 336 and Tm < 343then -0.374*Tm + 128.23else 0;
