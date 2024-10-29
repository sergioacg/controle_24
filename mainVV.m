%% Sistemas de Controle
% Reactor de Van de Vusse
% http://controlautomaticoeducacion.com/
%%
clc
close all
clear all
%Constantes
k1 = 5/6;
k2 = 5/3;
k3 = 1/6;
cafs = 10; 
fsov = 0:0.1:10;

%Vetor de Parametros
par.k1=k1; par.k2=k2; par.k3=k3; par.cafs=cafs;

%% Ponto de Equilibrio (Posibilidade 1)
cas1 = -(k1 + fsov)/(2*k3);
cas2 = sqrt((k1+fsov).^2 + 4*k3*fsov.*cafs)/(2*k3);
cas  = cas1 + cas2;
cbs = k1*cas./(fsov + k2);

t=[0 10];

%% Ponto de Equilibrio (Posibilidade 2)
x0=[1,1]; %Valores iniciales
for i=1:length(fsov)
    X(i,:) = fsolve(@(x)modeloR(t,x,fsov(i),par),x0); %X=[Ca Cb]
end

% Plotar
figure
subplot(2,1,1)
plot(fsov,cas,'Linewidth',2)
title('Concentraões vs F/V');
ylabel('Concentração C_{As} mol/litro');
legend('C_{As}','Location','SouthEast')
subplot(2,1,2)
plot(fsov,cbs,'Linewidth',2)
ylabel('Concentração C_{Bs} mol/litro');
legend('C_{Bs}','Location','SouthEast')
xlabel('F_s/V (min^{-1})');

%% Caso 1 (Resposta inversa)
% Ponto de equilibrio
fsov=4/7;
Eq1 = fsolve(@(x)modeloR(t,x,fsov,par),x0); %Eq1=[Ca Cb]

cae=Eq1(1);
cbe=Eq1(2);

% Comparação
du=0.01;   %Pequena Variação na entrada do sistema
fsov=4/7+du;

% Simula o Modelo Não Linear
[ts,X1] = ode45(@(t,x)modeloR(t,x,fsov,par), t , Eq1, fsov);

%Plota
figure
plot(ts,X1(:,2),'-b','LineWidth',2);
title('(caso 1)');
xlabel('tempo (min)');
ylabel('C_b mol/litro');
