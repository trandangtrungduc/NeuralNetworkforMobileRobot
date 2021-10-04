function digital_er=sensor(xc,yc,phic)
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

eqn1=(x-sy_xs)*(sy_xc-sy_xs)+(y-sy_ys)*(sy_yc-sy_ys)==0;
%%
% Tin hieu sai so ABD
eqnABD=[-1500<x,x<1500,y==0];
s=solve(eqn1,eqnABD,[x y]);
xr=double(s.x);
yr=double(s.y);
if (isempty(xr) && isempty(yr)) digital_er_ABD=[0 0 0 0 0 0 0];
else 

% % xls=double(sy_xls);
% % yls=double(sy_yls);
% % 
% % xs=double(sy_xs);
% % ys=double(sy_ys);

% ref_sign=(xs-xls)*(xr-xls)+(ys-yls)*(yr-yls);

% if ((xr-xs)~=0) ref_sign=(xr-xls)/(xs-xls);
% elseif ((yr-ys)~=0) ref_sign=(yr-yls)/(ys-yls);
% else ref_sign=0; 
% end
if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2); % Sai so so voi cam bien trai
er_ABD=er_2;
digital_er_ABD=digitalize(er_2);
end
%%
% Tin hieu sai so BCG

eqnBCG=[x*(500-0)==y*(-1000-0),-1000<x,x<1000,-500<y,y<500];
s=solve(eqn1,eqnBCG,[x y]);
xr=double(s.x);
yr=double(s.y);
if (isempty(xr) && isempty(yr)) digital_er_BCG=[0 0 0 0 0 0 0];
else 
% % xls=double(sy_xls);
% % yls=double(sy_yls);
% % xs=double(sy_xs);
% % ys=double(sy_ys);
% ref_sign=(xr-xls)/(xs-xls);
% ref_sign=(xs-xls)*(xr-xls)+(ys-yls)*(yr-yls);
% xr,xs
% xr-xs
% ref_sign=(xr-xs)/(xs-xls)
% ref_sign=(yr-ys)/(ys-yls)

if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end

% % if ((xr-xs)~=0) ref_sign=(xr-xls)/(xs-xls);
% % elseif ((yr-ys)~=0) ref_sign=(yr-yls)/(ys-yls);
% % else ref_sign=0;
% % end
% ref_sign
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2); % Sai so so voi cam bien trai
er_BCG=er_2;
digital_er_BCG=digitalize(er_2);  
end

%%
% Tin hieu sai so EBF

eqnEBF=[x*(500--500)==y*(1000--1000),-1000<x,x<1000,-500<y,y<500];

s=solve(eqn1,eqnEBF,[x y]);
xr=round(double(s.x),4);
yr=round(double(s.y),4);
if (isempty(xr) && isempty(yr)) digital_er_EBF=[0 0 0 0 0 0 0];
else 

% % xls=double(sy_xls);
% % yls=double(sy_yls);
% % 
% % xs=double(sy_xs);
% % ys=double(sy_ys);
% ref_sign=(xr-xls)/(xs-xls);
% ref_sign=(xs-xls)*(xr-xls)+(ys-yls)*(yr-yls);
% xr,xs,ys,yls
% xr-xs
% xs-xls
% yr-yls
% yr-ys
% 
% ys-yls
% ref_sign=(xr-xs)/(xs-xls)
% ref_sign=(yr-ys)/(ys-yls)
if ((xrs-xls)~=0) ref_sign=(xr-xs)/(xrs-xls);
elseif ((yrs-yls)~=0) ref_sign=(yr-ys)/(yrs-yls);
else ref_sign=0;
end
% ref_sign
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2);% Sai so so voi cam bien trai
er_EBF=er_2;
digital_er_EBF=digitalize(er_2);
end

%%
% Tin hieu sai so CDE

eqnCDE=[(x+1000)^2+y^2==500^2,-1500<x,x<-1000];
s=solve(eqn1,eqnCDE,[x y]);
xr=double(s.x);
yr=double(s.y);
num_sol=length(xr);
if (isempty(xr) && isempty(yr)) 
    digital_er_CDE=[0 0 0 0 0 0 0];
else 

% % xls=double(sy_xls);
% % yls=double(sy_yls);
% % 
% % xs=double(sy_xs);
% % ys=double(sy_ys);
% Nghiem 1 
% ref_sign=(xs-xls)*(xr(1)-xls)+(ys-yls)*(yr(1)-yls);
% ref_sign=(xr(1)-xls)/(xs-xls);

    if ((xr(1)-xls)~=0) ref_sign=(xr(1)-xs)/(xs-xls);
    elseif ((yr(1)-yls)~=0) ref_sign=(yr(1)-ys)/(ys-yls);
    else ref_sign=0; 
    end

    if (ref_sign >= 0) ref_sign=1;
    else ref_sign=-1;
    end
er_2=ref_sign*sqrt((xr(1)-xs).^2+(yr(1)-ys).^2); % Sai so so voi cam bien trai
digital_er_CDE=digitalize(er_2);
% Nghiem 2
% ref_sign=(xs-xls)*(xr(2)-xls)+(ys-yls)*(yr(2)-yls);
% ref_sign=(xr(2)-xls)/(xs-xls);
if (num_sol==2)

if ((xr(2)-xls)~=0) ref_sign=(xr(2)-xs)/(xs-xls);
elseif ((yr(2)-yls)~=0) ref_sign=(yr(2)-ys)/(ys-yls);
else ref_sign=0; 
end

if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end
er_2=ref_sign*sqrt((xr(2)-xs).^2+(yr(2)-ys).^2); % Sai so so voi cam bien trai
digital_er_CDE=digital_er_CDE|digitalize(er_2);
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
    digital_er_FAG=[0 0 0 0 0 0 0];
else 

% % xls=double(sy_xls);
% % yls=double(sy_yls);
% % 
% % xs=double(sy_xs);
% % ys=double(sy_ys);
% Nghiem 1
% ref_sign=(xs-xls)*(xr(1)-xls)+(ys-yls)*(yr(1)-yls);

if ((xr(1)-xls)~=0) ref_sign=(xr(1)-xs)/(xs-xls);
elseif ((yr(1)-yls)~=0) ref_sign=(yr(1)-ys)/(ys-yls);
else ref_sign=0; 
end
    
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end

er_2=ref_sign*sqrt((xr(1)-xs).^2+(yr(1)-ys).^2); % Sai so so voi cam bien trai
digital_er_FAG=digitalize(er_2);    
% Nghiem 2
% ref_sign=(xs-xls)*(xr(2)-xls)+(ys-yls)*(yr(2)-yls);
if (num_sol==2)
if ((xr(2)-xls)~=0) ref_sign=(xr(2)-xs)/(xs-xls);
elseif ((yr(2)-yls)~=0) ref_sign=(yr(2)-ys)/(ys-yls);
else ref_sign=0; 
end
    
if (ref_sign >= 0) ref_sign=1;
else ref_sign=-1;
end

er_2=ref_sign*sqrt((xr(2)-xs).^2+(yr(2)-ys).^2); % Sai so so voi cam bien trai
digital_er_FAG=digital_er_FAG|digitalize(er_2);
end
end

%Tin hieu sensor
digital_er=digital_er_ABD | digital_er_BCG | digital_er_EBF | digital_er_CDE | digital_er_FAG;

%% Code Nhap
% xls=double(sy_xls);
% yls=double(sy_yls);
% 
% xs=double(sy_xs);
% ys=double(sy_ys);
% 
% ref_sign=(xs-xls)*(xr-xls)+(ys-yls)*(yr-yls);
% 
% if (ref_sign >= 0) ref_sign=1;
% else ref_sign=-1;
% end
% er_2=ref_sign*sqrt((xr-xs).^2+(yr-ys).^2); % Sai so so voi cam bien trai
% 
% if ((d_sensor*2.5<=er_2)&&(er_2<d_sensor*3))         digital_er=[0 0 0 0 0 0 1];
% elseif ((d_sensor*1.5<=er_2)&&(er_2<d_sensor*2.5))   digital_er=[0 0 0 0 0 1 0];
% elseif ((d_sensor*0.5<=er_2)&&(er_2<d_sensor*1.5))   digital_er=[0 0 0 0 1 0 0];
% elseif ((d_sensor*-0.5<=er_2)&&(er_2<d_sensor*0.5))  digital_er=[0 0 0 1 0 0 0];
% elseif ((d_sensor*-1.5<=er_2)&&(er_2<d_sensor*-0.5)) digital_er=[0 0 1 0 0 0 0];
% elseif ((d_sensor*-2.5<=er_2)&&(er_2<d_sensor*-1.5)) digital_er=[0 1 0 0 0 0 0];
% elseif ((d_sensor*-3<=er_2)&&(er_2<d_sensor*-2.5))   digital_er=[1 0 0 0 0 0 0];
% else digital_er= [0 0 0 0 0 0 0];
% end

end

function digital_er=digitalize(er_2)
d_sensor=17;
if ((d_sensor*2.5<=er_2)&&(er_2<d_sensor*3))         digital_er=[0 0 0 0 0 0 1];
elseif ((d_sensor*1.5<=er_2)&&(er_2<d_sensor*2.5))   digital_er=[0 0 0 0 0 1 0];
elseif ((d_sensor*0.5<er_2)&&(er_2<d_sensor*1.5))   digital_er=[0 0 0 0 1 0 0];
elseif ((d_sensor*-0.5<=er_2)&&(er_2<=d_sensor*0.5))  digital_er=[0 0 0 1 0 0 0];
elseif ((d_sensor*-1.5<er_2)&&(er_2<d_sensor*-0.5)) digital_er=[0 0 1 0 0 0 0];
elseif ((d_sensor*-2.5<er_2)&&(er_2<=d_sensor*-1.5)) digital_er=[0 1 0 0 0 0 0];
elseif ((d_sensor*-3<er_2)&&(er_2<=d_sensor*-2.5))   digital_er=[1 0 0 0 0 0 0];
else digital_er= [0 0 0 0 0 0 0];
end
end