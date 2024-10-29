function [sys,x0]=modeloS(t,x,u,flag,par,cae,cbe)
%O Flag 0 � o passo onde indicamos para a S-Function o que ela vai
%encontrar quando ler o modelo. Isso � feito com un vetor de 6 elementos
%chamado nesse caso como sys
    if flag==0
       %Elemento 1: quantidade de estados continuos (Equa��es diferenciaveis)= 2
       %Elemento 2: Numero de estados discretos: 0
       %Elemento 3: Numero de sa�das do modelo: 2
       %Elemento 4: Numero de Entradas do modelo (FV): 1 entrada
       %Elemento 5: Alimenta��o Direta (Entradas afetando diretamente o estado
       %Elemento 6: Tipologia do processo, (0 para processos continuos)
       [sys]=[2,0,2,1,0,0];
       %Incluir condi��es iniciais
       x0=[cae cbe];
    elseif flag==1
        %Flag 1: Atualiza as equa��es diferenciais
       [sys]=modeloR(t,x,u,par);
    elseif flag==3
        %Flag 3: Calcula as sa�das do modelo, precisamos informar as nossas
        %saidas do sistema neste flag
       [sys]=x;
    else
        %Como passo final com um vetor nulo � fechado o bucle
       [sys]=[];
    end
end