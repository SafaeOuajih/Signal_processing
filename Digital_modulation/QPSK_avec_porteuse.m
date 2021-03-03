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
    Sl = Sl(81:1:length(Sl));
    %géneration de la porteuse f0
    n =[0:1:(length(Sl)-1)] ;
    Porteuse = exp(2i*pi*f0*n*Te);
    Sl_f0=Sl.*Porteuse'; %% Multiplication terme à terme
    S=real(Sl_f0); 
        %% Canal
                
    %% Recepteur
        %% filtre de réception
        ga= fliplr(conj(g)) ; %% ga(t) = g*(Tg - t)
        %% avec porteuse
        yi = 2* (real(Porteuse).*S') ; %% partie I
        yq = 2* (imag(Porteuse).*S'); %% partie Q
        yl = yi + i*yq;
        rl = conv(ga , yl);
        rln = rl(length(ga):Fse:length(rl)-length(ga)); % Downsampling
        %% Demodulation
        Sn=pskdemod(rln,4,pi/4,'gray');
        S_bin=de2bi(Sn);
    
        %% DSP
        M=512;
        [DSP_e, f] = pwelch(S,M,0,2*M,10*fs);
    
%% Affichage  des  resultats

%Constellations 
semilogy(f,abs(DSP_e));
title('DSP_S expérimentale');
     xlabel('f(Hz)');
     ylabel('DSP S');
eyediagram(rln(Fse:1000),3*Fse,3*Ts);
title('eye diagram rln'); 
hold on ;
eyediagram(Ss(Fse:1000),3*Fse,3*Ts)
title('eye diagram Ss');
hold off;
scatterplot(Ss);
title('Constellations Ss');
hold on ;


scatterplot(rln);
title('Constellations rln');
hold off;






