function [k_dT_dxi,k_dT_dyi,ki] = gradiente(ke,Temp,P,E,T)

X=P(1,:);
Y=P(2,:);

T1=T(1,:);
T2=T(2,:);
T3=T(3,:);

% ke=(k(T1)+k(T2)+k(T3))/3;

X1=X(T1);
X2=X(T2);
X3=X(T3);

Y1=Y(T1);
Y2=Y(T2);
Y3=Y(T3);
Temp1=Temp(T1)';
Temp2=Temp(T2)';
Temp3=Temp(T3)';

D=X2.*Y3-X3.*Y2+X3.*Y1-X1.*Y3+X1.*Y2-X2.*Y1;

A =(Temp1.*(Y2-Y3) + Temp2.*(Y3-Y1) + Temp3.*(Y1-Y2))./D;
B =(Temp1.*(X3-X2) + Temp2.*(X1-X3) + Temp3.*(X2-X1))./D;

k_dT_dx=-ke.*A;
k_dT_dy=-ke.*B;

k_dT_dxA=zeros(1,length(P));
k_dT_dyA=zeros(1,length(P));


Atri=D/2;

Atri1=Atri/3;
Atri2=Atri/3;
Atri3=Atri/3;

A_i=zeros(1,length(P));
for i=1:length(T)
A_i(T(1,i))=Atri1(i)+A_i(T(1,i));
A_i(T(2,i))=Atri2(i)+A_i(T(2,i));
A_i(T(3,i))=Atri3(i)+A_i(T(3,i));
end

for i=1:length(T)
k_dT_dxA(T(1,i))=Atri1(i)*k_dT_dx(i)+k_dT_dxA(T(1,i));
k_dT_dxA(T(2,i))=Atri2(i)*k_dT_dx(i)+k_dT_dxA(T(2,i));
k_dT_dxA(T(3,i))=Atri3(i)*k_dT_dx(i)+k_dT_dxA(T(3,i));

k_dT_dyA(T(1,i))=Atri1(i)*k_dT_dy(i)+k_dT_dyA(T(1,i));
k_dT_dyA(T(2,i))=Atri2(i)*k_dT_dy(i)+k_dT_dyA(T(2,i));
k_dT_dyA(T(3,i))=Atri3(i)*k_dT_dy(i)+k_dT_dyA(T(3,i));
end

k_dT_dxi=k_dT_dxA./A_i;
k_dT_dyi=k_dT_dyA./A_i;

kA=zeros(1,length(P));
for i=1:length(T)
kA(T(1,i))=Atri1(i)*ke(i)+kA(T(1,i));
kA(T(2,i))=Atri2(i)*ke(i)+kA(T(2,i));
kA(T(3,i))=Atri3(i)*ke(i)+kA(T(3,i));
end
ki=kA./A_i;




