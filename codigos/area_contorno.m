function [Aglobal,Xbci,Ybci] = area_contorno(P,E,T,n_contorno)
%nn=0, 2D plano.
%nn=1, 2D axissimétrico.
nn=0;
X=P(1,:);    Y=P(2,:);
no_c1=E(1,:);
no_c2=E(2,:);

Lno=(2*pi*Y).^nn;
Lbc_o=(Lno(no_c1)+Lno(no_c2))/2;

Xbc1=X(no_c1); Ybc1=Y(no_c1); %Coordenadas do nó 1 segmento de contorno
Xbc2=X(no_c2); Ybc2=Y(no_c2); %Coordenadas do nó 2 segmento de contorno
Xbci=(Xbc1+Xbc2)/2;
Ybci=(Ybc1+Ybc2)/2;

nx_bc=+(Ybc2-Ybc1).*Lbc_o;  %component X do vetor normal ao segmento de contorno
ny_bc=-(Xbc2-Xbc1).*Lbc_o;  %component y do vetor normal ao segmento de contorno

%vetor de áreas local = Comprimento do segmento de contorno
Area_LTOTAIS=(nx_bc.^2+ny_bc.^2).^0.5; % Comprimento do segmento de contorno
Area_L=zeros(size(Area_LTOTAIS));
Area_L(E(5,:)==n_contorno)=Area_LTOTAIS(E(5,:)==n_contorno);
% início - montagem do vetor de áreas global
Aglobal=zeros(length(P),1);     %Criação do vetor de Area global
for i=1:length(E)
Aglobal(E(1,i))=Area_L(i)/2+Aglobal(E(1,i));
Aglobal(E(2,i))=Area_L(i)/2+Aglobal(E(2,i));
end
