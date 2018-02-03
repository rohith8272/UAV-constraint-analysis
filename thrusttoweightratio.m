clear all;
close all;
clc;
Peta=0.6;
Meta=0.7;
rho=1.2;
rhoSL=1.225;
sig=rho/rhoSL
CD0=0.04;
e=0.8;
AR=6.5;
V=15;
Vstall=10;
W=7;%AUW in kg
WS=0:1:100;%wing loading in N/m^2
q=0.5*rho*V.^2;
k=1/(pi*e*AR);
ROC=3;
%%
%max speed
TWmaxvelocity=((q*CD0)*WS.^-1)+((k*WS)*q.^-1);
%Vinf=12:1:18
PWmaxspeed=V*(TWmaxvelocity*(Peta*Meta).^-1)
%%
%ceiling
CLmp=sqrt(3*CD0/k)
Vceiling=sqrt(2*WS/rho*CLmp)
B=k*q.^-2
C=Peta*Meta*sig*CLmp
PWceiling=Vceiling.*(CD0+(B*WS.^2))/C
TWceiling=PWceiling/V;
 
%%
%rate of climb
PWroc=(1/(Meta*Peta*sig))*(ROC+(Vceiling.*(CD0+(k*q.^-2)*(WS.^2))*CLmp.^-1))
TWroc=PWroc/V; 
%%
%turn
n=V/Vstall
TWturn=(q*CD0*WS.^-1)+(n.^2)*((k*WS)*q^-1)
PWturn=V*TWturn;


%plot(WS,PWmaxspeed,WS,PWceiling,WS,PWroc,WS,PWturn)
%xlabel('wing loading N/m^2')
%ylabel('power loading W/N')


plot(WS,TWmaxvelocity,WS,TWroc,WS,TWturn,WS,TWceiling)
xlabel('wing loading N/m^2')
ylabel('thrust loading')
