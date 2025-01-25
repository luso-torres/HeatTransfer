P = [0 0
    1 0
    2 0
    3 0
    4 0
    5 0
    0 .5
    1 0.4
    2 0.3
    3 0.2
    4 0.1].'*10^-2;
E= [ 1 2
    2 3
    3 4
    4 5
    5 6
    6 11
    11 10
    10 9
    9 8
    8 7
    7 1].';
T= [1 2 7
    2 8 7
    2 3 8
    3 9 8
    3 4 9
    4 10 9
    4 5 10
    5 11 10
    5 6 11].';
X1=P(1,T(1,:));
X2=P(1,T(2,:));
X3=P(1,T(3,:));

Y1=P(2,T(1,:));
Y2=P(2,T(2,:));
Y3=P(2,T(3,:));

Xo = (X1+X2+X3)/3;
Yo = (Y1+Y2+Y3)/3;
figure(5); pdemesh(P,E,T),axis equal,
X12=(X1+X2)/2;  X32=(X3+X2)/2;  X13=(X1+X3)/2;
Y12=(Y1+Y2)/2;  Y32=(Y3+Y2)/2;  Y13=(Y1+Y3)/2;
pdemesh(P,E,T),hold on,title('Malha de Volumes e de Elementos','Fontsize',16)
for i=1:length(X1)
plot([X12(i) Xo(i)],[Y12(i) Yo(i)],'-m',[X32(i) Xo(i)],[Y32(i) Yo(i)],'-m',[X13(i) Xo(i)],[Y13(i) Yo(i)],'-m'),hold on
end
