function er=er_2(xc,yc,phic)
syms sy_xc sy_yc sy_phi x y kccb
syms sy_xs sy_ys sy_xls sy_yls
d_sensor=17;
kcc=d_sensor*3;% 17*3

kccb=172.68;% khoang cach cam bien truc xe
sy_xc=xc;
sy_yc=yc;
sy_phi=phic;
sy_xs=sy_xc+kccb*cos(sy_phi);
sy_ys=sy_yc+kccb*sin(sy_phi);
sy_xls=sy_xs+kcc*cos(sy_phi+pi/2);
sy_yls=sy_ys+kcc*sin(sy_phi+pi/2);

xls=round(double(sy_xls),4);
yls=round(double(sy_yls),4);

xs=round(double(sy_xs),4);
ys=round(double(sy_ys),4);

xrs=2*xs-xls;
yrs=2*ys-yls;

er=99999;

eqn1=(x-sy_xs)*(sy_xc-sy_xs)+(y-sy_ys)*(sy_yc-sy_ys)==0;
%%
% Tin hieu sai so ABD
eqnABD=[-1500<x,x<1500,y==0];
s=solve(eqn1,eqnABD,[x y]);
xr=double(s.x);
yr=double(s.y);
if (isempty(xr) && isempty(yr)) 

else 


if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2); % Sai so so voi cam bien trai
er=er_2;
end
%%
% Tin hieu sai so BCG

eqnBCG=[x*(500-0)==y*(-1000-0),-1000<x,x<1000,-500<y,y<500];
s=solve(eqn1,eqnBCG,[x y]);
xr=double(s.x);
yr=double(s.y);
if (isempty(xr) && isempty(yr))
%     digital_er_BCG=[0 0 0 0 0 0 0];
else 


if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end


if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2); % Sai so so voi cam bien trai
if (abs(er_2)< abs(er)) er=er_2; end
end

%%
% Tin hieu sai so EBF

eqnEBF=[x*(500--500)==y*(1000--1000),-1000<x,x<1000,-500<y,y<500];

s=solve(eqn1,eqnEBF,[x y]);
xr=round(double(s.x),4);
yr=round(double(s.y),4);
if (isempty(xr) && isempty(yr)) 

else 


if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2);% Sai so so voi cam bien trai
if (abs(er_2)<abs(er)) er=er_2; end
end

%%
% Tin hieu sai so CDE

eqnCDE=[(x+1000)^2+y^2==500^2,-1500<x,x<-1000];
s=solve(eqn1,eqnCDE,[x y]);
xr=double(s.x);
yr=double(s.y);
num_sol=length(xr);
if (isempty(xr) && isempty(yr)) 
else 


% Nghiem 1 


if ((xr(1)-xls)~=0) ref_sign=(xr(1)-xs)/(xs-xls);
elseif ((yr(1)-yls)~=0) ref_sign=(yr(1)-ys)/(ys-yls);
else ref_sign=0; 
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr(1)-xs).^2+(yr(1)-ys).^2); % Sai so so voi cam bien trai

if (abs(er_2)<abs(er)) er=er_2; end

% Nghiem 2

if (num_sol==2)

if ((xr(2)-xls)~=0) ref_sign=(xr(2)-xs)/(xs-xls);
elseif ((yr(2)-yls)~=0) ref_sign=(yr(2)-ys)/(ys-yls);
else ref_sign=0; 
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr(2)-xs).^2+(yr(2)-ys).^2); % Sai so so voi cam bien trai
if (abs(er_2)<abs(er)) er=er_2; end

end
end
%%
% Tin hieu sai so FAG

eqnFAG=[(x-1000)^2+y^2==500^2,1000<x,x<1500];
s=solve(eqn1,eqnFAG,[x y]);
xr=double(s.x);
yr=double(s.y);
num_sol=length(xr);
if (isempty(xr) && isempty(yr)) 

else 


% Nghiem 1

if ((xr(1)-xls)~=0) ref_sign=(xr(1)-xs)/(xs-xls);
elseif ((yr(1)-yls)~=0) ref_sign=(yr(1)-ys)/(ys-yls);
else ref_sign=0; 
end
    
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end

er_2=ref_sign*sqrt((xr(1)-xs).^2+(yr(1)-ys).^2); % Sai so so voi cam bien trai
if (abs(er_2)<abs(er)) er=er_2; end
% Nghiem 2

if (num_sol==2)
if ((xr(2)-xls)~=0) ref_sign=(xr(2)-xs)/(xs-xls);
elseif ((yr(2)-yls)~=0) ref_sign=(yr(2)-ys)/(ys-yls);
else ref_sign=0; 
end
    
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end

er_2=ref_sign*sqrt((xr(2)-xs).^2+(yr(2)-ys).^2); % Sai so so voi cam bien trai
if (abs(er_2)<abs(er)) er=er_2; end
end
end

%Tin hieu sensor



end
