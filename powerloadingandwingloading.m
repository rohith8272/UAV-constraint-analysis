%%%constraint analysis 2---
clc;
clear;
%% Inputs
AR=6.5; %Aspect Ratio
e=0.85; %Oswald's efficiency
Cd0=0.0538; %Zero lift drag
nP=0.60; %Propeller efficiency
nM=0.60; %Motor efficiency
TOalt=1300; %Takeoff altitude(m)
Clmax=1.4; %Maximum lift coefficent
TOdist=10; %Takeoff distance (m)
Lalt=1300; %Landing ALtitude (m)
Ceiling=2500; %Ceiling (m)
ROCalt=60; %(m)
ROC=5; %(m/sec)
SpeedAlt=50; %(m)
V=15; %Airspeed(m/sec)
TurnAlt=50; %(m)
TurnSpeed=13; %(m/sec)
D=25.4; %propeller diameter (cm)
d=D*0.0328084; %propeller diameter (feet)
n=1.15; %Load factor
alphaBANK=acos(1/n); %Bank Angle
rhoSL=1.225; %Density at sea level (kg/m^3)
rho1300=0.995; %Density at 1300 m (kg/m^3)
rho1400=0.98; %Density at 1400 feet (kg/m^3)
K=1/(pi*e*AR); %Cd=Cd0+KCl^2
g=9.81; %accn due to gravity (m/sec^2)
alphaTO=0.84; %angle of attack TAKEOFF(radians)
alphaL=0.84; %angle of attack LANDING(radians)
alphaC=0.93; %angle of attack CEILING(radians)
alphaROC=0.9; %angle of attack ROC(radians)
sigma1300=rho1300/rhoSL; %Relative air density sigma at 1300ft sigma1400=rho1400/rhoSL; %Relative air density sigma at 1400 ft
WTO_S=20:1:150; %Wing loading (N/m^2)
LbyDmax=(1/2)*((K*Cd0)^(-0.5)); %L/Dmax
%% Assumptions
%AOA BANK = AS PER LOAD FACTOR Cos(THETA)=(1/n)
%% Takeoff condition
Vstall=((2*WTO_S./(sigma1300*rhoSL*Clmax)).^0.5) %Stall velocity
VTO=1.2*Vstall; %Takeoff velocity
PbWtoff=((0.7*VTO).^3/(2*550*alphaTO*nP*nM*g*d))/4.4482; %Power/Weight (Watts/N)
plot(WTO_S,PbWtoff,'.-'),grid on,xlabel('Wing loading (N/m^2)'),ylabel('Power loading (Watts/N)');
hold on;
%% Landing condition
Vstall=(2*WTO_S./(sigma1300*rhoSL*Clmax)).^0.5; %Stall velocity
VTO=1.2*Vstall; %Takeoff velocity
PbWlanding=((VTO).^3/(550*alphaL*nP*nM*g*d))/4.4482; %Power/Weight (Watts/N)
plot(WTO_S,PbWlanding,'.r-'),grid on,xlabel('Wing loading (N/m^2)'),ylabel('Power loading (Watts/N)');
hold on;
%% Ceiling condition
Cl1400=((3*Cd0)/K)^0.5; %Cl at 1400 ft
V1400=(2*WTO_S./(rho1400*Cl1400)).^(0.5); %Velocity at 1400 ft
PbWceiling=(V1400)/(0.866*550*alphaC*nP*nM*g*(sigma1300)^0.5)/4.4482; %Power/Weight (Watts/N)
plot(WTO_S,PbWceiling,'.g-'),grid on,xlabel('Wing loading (N/m^2)'),ylabel('Power loading (Watts/N)');
hold on;
%% Rate of climb
Clmd=((3*Cd0)/K)^0.5; %Cl at min drag
Vmd=(2*WTO_S./(rho1400*Clmd)).^0.5; %Velocity at min drag
PbWroc=(1/(550*alphaROC*nP*nM))*((ROC)+((Vmd)/(0.866*LbyDmax*(sigma1300)^0.5)))/4.4482; %Power/Weight (Watts/N)
plot(WTO_S,PbWroc,'.m-'),grid on,xlabel('Wing loading (N/m^2)'),ylabel('Power loading (Watts/N)');
hold on;
%% Turning flight
q=0.5*rho1400*V^2; %Dynamic pressure
T_W=(1/alphaBANK)*((q.*Cd0./WTO_S)+((K*WTO_S*n^2)./q)); %Thrust to weight ratio
PbWturn=(V*T_W/(550*nP*nM))/4.4482; %Power/Weight (Watts/N)
plot(WTO_S,PbWturn,'.y-'),grid on,xlabel('Wing loading (N/m^2)'),ylabel('Power loading (Watts/N)');
legend('Takeoff','Landing','Ceiling','Rate of climb','Turning')
%% END