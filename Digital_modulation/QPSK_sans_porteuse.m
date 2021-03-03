%% Safae OUAJIH
clear;      % Efface  les  variables  de l'environnement  de travail

close  all; % Ferme  les  figures  ouvertes

clc;         % Efface  la  console



%% Initialisation  des  parametres

fe = 1e4; % Fréquence d’échantillonnage
Te = 1/fe; % Période d’échantillonnage
Fse = 10 ;% Facteur de upsampling
N=5000; % nombre de symboles par paquet
Ts = 1e-3 ;% Temps symbole
fs =1/Ts; % Fréquence symbole
f0 = 2500;
    %% emetteur
    Sb = randi([0,1],N,2); %% signal binaire
    Sd = bi2de(Sb);        %% conversion en décimal
    Ss = pskmod(Sd,4,pi/4,'gray'); %% modulation
    Ssu=upsample(Ss,Fse); %% Sur_échantillonage
    % Filtre de mise en forme cos sur_élevé
    g=rcosfir(0.5,4,Fse,Ts,'sqrt');
    Sl = conv(g, Ssu);
    
        %% Canal
                
    %% Recepteur
        %% filtre de réception
        ga= fliplr(conj(g)) ; %% ga(t) = g*(Tg - t)
        %% sans porteuse    
        rl = conv(g , Sl);
        rln = rl(length(ga):Fse:length(rl)-length(ga)); % DOWN SAMPLING
        % Demodulation
        Sn=pskdemod(rln,4,pi/4,'gray');
        S_bin=de2bi(Sn);
  
%% Affichage  des  resultats
eyediagram(Ss(Fse:1000),3*Fse,3*Ts)
title('eye diagram Ss');

eyediagram(rln(Fse:1000),3*Fse,3*Ts);
title('eye diagram rln');

