% Luu anh xe
% Chay sau khi co ket qua main
kccb=172.68;% khoang cach cam bien truc xe
kcc=51;

x;
y;
phi;

xc=x+kccb*cos(phi);
yc=y+kccb*sin(phi);

xls=xc+kcc*cos(phi+pi/2);
yls=yc+kcc*sin(phi+pi/2);

xrs=2*xc-xls;
yrs=2*yc-yls;

xxe1=[xls', xrs'];
yxe1=[yls', yrs'];

xxe2=[x', xc'];
yxe2=[y', yc'];

hold on

for i=1:3:length(x)
plot(xxe1(i,1:2),yxe1(i,1:2),'LineWidth',2,'Color','r');
plot(xxe2(i,1:2),yxe2(i,1:2),'LineWidth',2,'Color','r');
end
