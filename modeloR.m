function x = modeloR(~,x,u,par)

   k1  = par.k1; % (min^-1)
   k2  = par.k2; % (min^-1)
   k3  = par.k3; % (mol/(liter min)
   caf = par.cafs; %  mol/liter
   fov = u; % (min^-1)
 
   %Definición de las Variables de Estado
   ca   = x(1);
   cb   = x(2);
%
%  Sistema de Ecuaciones
%
   dcadt = fov*(caf - ca) -k1*ca - k3*ca*ca;
   dcbdt = -fov*cb + k1*ca - k2*cb;
%
%  Vector de Estados
%
   x = [dcadt;dcbdt];