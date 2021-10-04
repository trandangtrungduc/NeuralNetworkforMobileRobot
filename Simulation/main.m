% Vi tri ban dau
x=[];y=[];phi=[];
x(1)=1500;
y(1)=0;
phi(1)=pi;
% phi(1)=pi-atan(500/1000);

delt=0.15;
% wr(1)=0;
% wl(1)=0;
hold on
phi_count_r=0;
phi_count_l=0;
phi_count_limit=atan(500/1000);
turn_right=0;turn_left=0;
turn_right_count=3;turn_left_count=1;
for i=1:394
    
% Doc cam bien
i
if (turn_right==1) turn_right, end
if (turn_left==1) turn_left, end
% plot(x(i),y(i),'*')
% turn_right,turn_left


sen(i,:)=sensor(x(i),y(i),phi(i));

% if (sen(i,1:7)==[0 0 1 1 1 0 0]) turn_right=1; end
if ( (i>45) & (i<100) & (sen(i,1:7)==[0 0 1 1 1 0 0])) turn_right=1; end
% if ((i>27) & (sen(i,1:7)== [0 0 1 1 1 0 0])) turn_right=1; end;
% if (i==turn_right_count+10) turn_right=1; end

if ((sen(i,1:7)== [0 0 1 0 1 0 0]) & (i>338)) turn_left=1; end;


if (turn_right==1) 
w_left(i)=0.9*200/40;
w_right(i)=0.5*200/40;
elseif (turn_left==1)
w_left(i)=0.5*200/40;
w_right(i)=0.9*200/40; 
% w_left(i)=0.7*pi/6;
% w_right(i)=1*pi/6; 
else
    
% Tinh van toc
[w_left(i) w_right(i)]=controller(sen(i,:));
end

% Cap nhat vi tri
% i=i+1;
phi(i+1)=phi(i)+delt*(w_right(i)-w_left(i))*40/165;
x(i+1)=x(i)+delt*40*(w_right(i)+w_left(i))*cos(phi(i))/2;
y(i+1)=y(i)+delt*40*(w_right(i)+w_left(i))*sin(phi(i))/2;

if (turn_right==1) phi_count_r=phi_count_r+delt*(w_right(i)-w_left(i))*40/165; end
if ((sen(i,1:7)==[0 0 0 1 0 0 0]) & (turn_right==1)) turn_right=0; end
% if (-phi_count_limit<phi_count_r) turn_right=0; end


if (turn_left==1) phi_count_l=phi_count_l+delt*(w_right(i)-w_left(i))*40/165; end
% if ((turn_left==1)& (i==turn_left_count+90)) turn_left=0; end
if ((sen(i,1:7)==[0 0 0 1 0 0 0]) & (turn_left==1)) turn_left=0; end
% if (phi_count_l>phi_count_limit) turn_left=0; end


end

for i=1:length(x) er(i)=er_2(x(i),y(i),phi(i));i, end

figure;
saban;
plot(x,y);
title('Quy dao cua xe')
xlabel('x (mm)') 
ylabel('y (mm)') 

figure;
t=0:0.15:0.15*393;
plot(t,w_left*60/(2*pi),t,w_right*60/(2*pi))
title('Do thi van toc cua xe')
xlabel('t(s)') 
ylabel('rpm') 
legend({'Van toc banh trai','Van toc banh phai'},'Location','southwest')

figure;
plot(t(1:380),er(1:380))
title('Do thi sai so e2 cua xe')
xlabel('t(s)') 
ylabel('error (mm)') 

figure;
Luuanh;
saban;
title('Mo phong xe di tren sa ban')
xlabel('x (mm)') 
ylabel('y (mm)') 

figure;
saban;title('Mo phong xe di tren sa ban')
xlabel('x (mm)') 
ylabel('y (mm)')
testanimation