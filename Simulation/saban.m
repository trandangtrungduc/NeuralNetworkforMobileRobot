% Sa ban co tam O tai giua
% 165mm hai banh xe, truc sau toi banh da huong 111.34mm,
% cam bien toi truc banh sau 172.68mm, hai cam bien la 17mm
% Toa do A(0,1500) B(0,0) C(-1000,500) D(-1500,0) E(-1000,-500)
% F(1000,500) G(1000,-500)
function [XX YY phi]=saban
XX=[];YY=[];
%AB
[x y]=drawline([1500 0],[0 0],50);
XX=[XX x]; YY=[YY y];
%BC
[x y]=drawline([0 0],[-1000 500],50);
XX=[XX x]; YY=[YY y];
%CDE
[x y]=drawarc([-1000 0],90,180,500,100);
XX=[XX x]; YY=[YY y];
%EBF
[x y]=drawline([-1000 -500],[1000 500],50);
XX=[XX x]; YY=[YY y];
%FAG
[x y]=drawarc([1000 0],90,-180,500,100);
XX=[XX x]; YY=[YY y];
%GB
[x y]=drawline([1000 -500],[0 0],50);
XX=[XX x]; YY=[YY y];
%BD
[x y]=drawline([0 0],[-1500 0],50);
XX=[XX x]; YY=[YY y];
plot(XX,YY,'Color','k','LineWidth',2.6);
axis equal
hold on
phi=[];
for i=1:length(XX)-1
phi(i)=atan2((YY(i+1)-YY(i)),(XX(i+1)-XX(i)));
end
phi(length(XX))=phi(length(XX)-1);
% xechay(XX,YY,phi);

end





function [x y]=drawline(A,B,t)

x=linspace(A(1),B(1),t);
y=linspace(A(2),B(2),t);

end

function [x y]=drawarc(center,start,angle,r,t)
angle=linspace(0,angle,t);
for i=1:t
    x(i)=r*cosd(start+angle(i))+center(1);
    y(i)=r*sind(start+angle(i))+center(2);
end
end

function xechay(XX,YY,phi)
kccb=172.68;kcc=51;
for i=1:length(XX)
xls(i)=XX(i)+kcc*cos(phi(i)+pi/2);
yls(i)=YY(i)+kcc*sin(phi(i)+pi/2);
xrs(i)=2*XX(i)-xls(i);
yrs(i)=2*YY(i)-yls(i);
plot([xls(i) xrs(i)],[yls(i) yrs(i)],'b');
end

end

% function Xe(x0,y0,phi0)
% vr=1000;%mm/s
% wr;
% t=1;%1s
% 
% v=vr*cos(e3)+k1*e1;
% w=k2*vr*e2+wr+k3*e3;
% i=1;kccb=172.68;% khoang cach cam bien truc xe
% kcc=51; % khoang cach cam bien ngoai cung voi cam bien tam 17*3
% x1(1)=x0;
% y1(1)=y0;
% phi1(1)=phi0; % phic=phi1
% xc(1)=x1(1)+kccb*cos(phi1(1));
% yc(1)=y1(1)+kccb*sin(phi1(1));
% xls(1)=xc(1)+kcc*cos(phi1(1)+pi/2);
% yls(1)=yc(1)+kcc*sin(phi1(1)+pi/2);
% xrs(1)=2*xc(1)-xls(1);
% yrs(1)=2*yc(1)-yls(1);
% plot([xls xrs],[yls yrs],[x1 xc],[y1 yc]);
% while 
% phi1(idx+1)=phi1(idx)+w*t;
% x1(idx+1)=x1(idx)+v*t*cos(phi(idx+1));
% y1(idx+1)=y1(idx)+v*t*sin(phi(idx+1));
% idx=idx+1;
% end
% end
% function [xr yr]=findr(left_sensor,right_sensor)
% syms xls yls xrs yrs x y
% xls=left_sensor(1);
% yls=left_sensor(2);
% xrs=right_sensor(1);
% yrs=right_sensor(2);
% eqn1=(x-xls)*(yls-yrs)==(y-yls)*(xls-xrs);
% eqnAB=[0<x<1500,y==0];
% % eqnBC=[x*(500-0)==y*(-1000-0),-1000<x,x<0,0<y,y<500];
% % eqnCDE=[(x+1000)^2+y^2=500^2,-1500<x,x<-1000];
% % eqnEBF=[x*(500--500)==y*(1000--1000),-1000<x,x<1000,-500<y,y<500];
% % eqnFAG=[(x-1000)^2+y^2=500^2,1000<x,x<1500];
% % eqnGB=[x*(500-0)==y*(-1000-0),0<x<1000,-500<y,y<0];
% % eqnBD=[-1500<x,x<0,y==0];
% s=solve(eqn1,eqnAB,[x y]);
% xr=double(s.x);
% yr=double(s.y);
% % isempty(xr); isempty(yr);
% % e2=sqrt((xr-xc)^2+(yr-yc)^2);
% end