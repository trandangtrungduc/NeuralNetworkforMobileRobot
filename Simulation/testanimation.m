% t=linspace(0,4*pi,450);
% x0=100*t;
% y0=0*t;
% phi0=0*sin(t/10);
% [XX YY phi]=saban;
% saban;
XX=x;
YY=y;
phi=phi;
x0=XX;
y0=YY;
phi0=phi;


i=1;kccb=172.68;% khoang cach cam bien truc xe
kcc=51; % khoang cach cam bien ngoai cung voi cam bien tam 17*3
x1=x0;
y1=y0;
phi1=phi0; % phic=phi1

xc=x1+kccb*cos(phi1);
yc=y1+kccb*sin(phi1);

xls=xc+kcc*cos(phi1+pi/2);
yls=yc+kcc*sin(phi1+pi/2);

xrs=2*xc-xls;
yrs=2*yc-yls;

xxe1=[xls(1) xrs(1)];
yxe1=[yls(1) yrs(1)];

xxe2=[x1(1) xc(1)];
yxe2=[y1(1) yc(1)];

hold on

xe1=plot(xxe1,yxe1,'LineWidth',5);
xe2=plot(xxe2,yxe2,'LineWidth',3);

hold off
axis([-2000 2000 -1000 1000]);errr=[];

% for i=1:length(x0)
% sensor(x0(i),y0(i),phi0(i))
% end

for i=1:length(XX)
sensor(x0(i),y0(i),phi0(i))
xe1.XData=[xls(i) xrs(i)];
xe1.YData=[yls(i) yrs(i)];
xe2.XData=[x1(i) xc(i)];
xe2.YData=[y1(i) yc(i)];
drawnow
% Sai so
end

% x = linspace(0,10,1000);
% y = sin(x);
% plot(x,y)
% xx=[x x+1];
% yy=[y y+1];
% hold on
% p = plot(x(1),y(1),'o','MarkerFaceColor','red');
% p1 =plot(2*x(1),1.5*y(1),'o','MarkerFaceColor','red');
% p2 =plot(xx,yy,'--'); 
% hold off
% axis manual
% for k = 2:length(x)
%     p.XData = x(k);
%     p.YData = y(k);
%     p1.XData = 2*x(k);
%     p1.YData = 1.5*y(k);
%     p2.XData = [x(k) x(k)+1];
%     p2.YData = [y(k) 2*y(k)];
%     drawnow
% end