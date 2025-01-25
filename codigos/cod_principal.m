clear all;
close all;
clc;
format long;
%Para cada situação, escolha a malha a se utilizar
%malha_refinada_manual_2;
%malha_refinada_manual;
malha_grossa;

%Condição escolhida da dupla
P=3*P;

X=P(1,:);     Y=P(2,:);
Xc= (X(T(1,:))+X(T(2,:))+X(T(3,:)))/3;
Yc= (Y(T(1,:))+Y(T(2,:))+Y(T(3,:)))/3;
dX =X(E(2,:))-X(E(1,:));        % Esquemático para determinação do contorno
dY =Y(E(2,:))-Y(E(1,:));        %            c           (+)
E(5,dX<0)=1;                    %      dY |  |\           ^
E(5,dX>0)=2;                    %         v  | \          |dY
E(5,dY<0)=3;                    %        (-) |  \   c1 
E(5,1)=3;       % ponto inicial %     c3     |   \     (-)<-dX
                                %            | _ _\  
                                %            a  c2  b
                                %             dX->(+)     
%Contador de pontos na base
base=Y==0;
no_base=sum(base);

n_nos=length(P) %número de nós
n_ele=length(T) %número de elementos
% fim- Malha de elementos finitos. 

% início - propriedades do material
k=180*ones(size(T(1,:)));
% fim - propriedades do material

% Montagem da matriz global (Aij) a partir das matrizes locais Cij
[A] = Monta_A(k,P,T);
% fim - montagem da matriz global (Aij) a partir das matrizes locais Cij

%%Cálculos associados a condição de contorno 4
[Aglobal] = area_contorno(P,E,T,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fim - montagem do vetor de áreas global

%apresentação dos valores de áreas associadas aso contornos

% nós nos contornos, conforme exemplo 5.2 do livro

no_cc1=E(1,E(5,:)==1); %nó contorno convectivo;
no_cc2=E(1,E(5,:)==2); %nó simetria;
no_cc3=E(1,E(5,:)==3); %nó temperatura especificada;

% início-modificação da matriz global para incluir as condições de contorno

B=zeros(length(P),1);  % termo independente

% for jj=1:length(no_cc2)
% A(no_cc2(jj),:)=0;            %zera a equação jj
% A(no_cc2(jj),no_cc2(jj))=1;  %faz o Ajj=1
% B(no_cc2(jj))=T_esp; 
% end

T_inf=25;%(K)
h0=15;%W/(m^2*K)
T_esp=200;%(K)

for jj=1:length(no_cc3)
A(no_cc3(jj),:)=0;           %zera a equação jj
A(no_cc3(jj),no_cc3(jj))=1;  %faz o Ajj=1
B(no_cc3(jj))=T_esp; 
end

for jj=1:length(no_cc1)
    %adição de condição na diagonal
A(no_cc1(jj),no_cc1(jj))=A(no_cc1(jj),no_cc1(jj))-h0*Aglobal(no_cc1(jj));  
B(no_cc1(jj))=-h0*Aglobal(no_cc1(jj))*T_inf;
end
% fim- modificação da matriz global para incluir as condições de contorno

% início - solução sistema de equações
Temp=A\B;
% fim - solução sistema de equações

% apresentação gráfica do resultado
figure(1),
trisurf(T',X,Y,Temp),view(0,90),shading interp, 
colorbar,colormap jet,title('Campo Temperaturas')
figure(2);
[k_dT_dxi,k_dT_dyi,ki] = gradiente(k,Temp,P,E,T);
quiver(X,Y,k_dT_dxi,k_dT_dyi,1),axis equal,hold on
plot(X(no_cc2),Y(no_cc2),'o',X(no_cc3),Y(no_cc3),'s',X(no_cc1),Y(no_cc1),'d')
%argumento 1 do plot:
legend('Vetores de fluxo', 'Simetria','Entrada','Saída')
%argumento 2 do legend:;
 plot([X(1) X(2) X(3)],[Y(1) Y(2) Y(3)]);

 figure(3); pdemesh(P,E,T),axis equal, 
 for i=1:no_base
 text(X(E(1,i)),Y(E(1,i)),{Temp(E(1,i))}),title('Temperaturas nos contornos da base')
 end
 
 figure(4), plot([ 0.01 0.02 0.03 .04 .05],[198.6 197.1 195.7 194.3 192.9],'o'...
      ,X(Y==0),Temp((Y==0)),'-')
  axis([0 .05 190 200]), title('Comparação entre soluções')
  xlabel('Posição(m)'),ylabel('Temperatura(K)')
  legend('Simulação do Exemplo 5.2','Simulação CVFEM',4)
  
  Q=h0.*Aglobal.*(Temp-T_inf)
  QT=sum(Q)