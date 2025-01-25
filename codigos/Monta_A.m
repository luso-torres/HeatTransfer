function [A] = Monta_A(k,P,T)

X=P(1,:); Y=P(2,:);

T1=T(1,:); T2=T(2,:); T3=T(3,:);
X1=X(T1);  X2=X(T2);  X3=X(T3);
Y1=Y(T1);  Y2=Y(T2);  Y3=Y(T3);

Xo=(X1+X2+X3)/3;  Xa=(X1+X2)/2;    Xb=(X3+X2)/2;  Xc=(X1+X3)/2;
Yo=(Y1+Y2+Y3)/3;  Ya=(Y1+Y2)/2;    Yb=(Y3+Y2)/2;  Yc=(Y1+Y3)/2;

nSx_ao=+(Yo-Ya); nSx_oa=-nSx_ao;
nSy_ao=-(Xo-Xa); nSy_oa=-nSy_ao;

nSx_bo=+(Yo-Yb); nSx_ob=-nSx_bo;
nSy_bo=-(Xo-Xb); nSy_ob=-nSy_bo;

nSx_co=+(Yo-Yc); nSx_oc=-nSx_co;
nSy_co=-(Xo-Xc); nSy_oc=-nSy_co;

D=X2.*Y3-X3.*Y2+X3.*Y1-X1.*Y3+X1.*Y2-X2.*Y1;

C11=k.*((Y2-Y3).*nSx_ao+(X3-X2).*nSy_ao+(Y2-Y3).*nSx_oc+(X3-X2).*nSy_oc)./D;
C12=k.*((Y3-Y1).*nSx_ao+(X1-X3).*nSy_ao+(Y3-Y1).*nSx_oc+(X1-X3).*nSy_oc)./D;
C13=k.*((Y1-Y2).*nSx_ao+(X2-X1).*nSy_ao+(Y1-Y2).*nSx_oc+(X2-X1).*nSy_oc)./D;

C21=k.*((Y2-Y3).*nSx_oa+(X3-X2).*nSy_oa+(Y2-Y3).*nSx_bo+(X3-X2).*nSy_bo)./D;
C22=k.*((Y3-Y1).*nSx_oa+(X1-X3).*nSy_oa+(Y3-Y1).*nSx_bo+(X1-X3).*nSy_bo)./D;
C23=k.*((Y1-Y2).*nSx_oa+(X2-X1).*nSy_oa+(Y1-Y2).*nSx_bo+(X2-X1).*nSy_bo)./D;

C31=k.*((Y2-Y3).*nSx_co+(X3-X2).*nSy_co+(Y2-Y3).*nSx_ob+(X3-X2).*nSy_ob)./D;
C32=k.*((Y3-Y1).*nSx_co+(X1-X3).*nSy_co+(Y3-Y1).*nSx_ob+(X1-X3).*nSy_ob)./D;
C33=k.*((Y1-Y2).*nSx_co+(X2-X1).*nSy_co+(Y1-Y2).*nSx_ob+(X2-X1).*nSy_ob)./D;

% A = zeros(length(P),length(P));
A = spalloc(length(P),length(P),length(P)*length(P)*1);
for i=1:length(T)
A(T1(i),T1(i))=C11(i)+A(T1(i),T1(i));
A(T1(i),T2(i))=C12(i)+A(T1(i),T2(i));
A(T1(i),T3(i))=C13(i)+A(T1(i),T3(i));
A(T2(i),T1(i))=C21(i)+A(T2(i),T1(i));
A(T2(i),T2(i))=C22(i)+A(T2(i),T2(i));
A(T2(i),T3(i))=C23(i)+A(T2(i),T3(i));
A(T3(i),T1(i))=C31(i)+A(T3(i),T1(i));
A(T3(i),T2(i))=C32(i)+A(T3(i),T2(i));
A(T3(i),T3(i))=C33(i)+A(T3(i),T3(i));
end