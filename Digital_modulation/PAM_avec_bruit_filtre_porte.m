%% Safae OUAJIH
clear;      % Efface  les  variables  de l'environnement  de travail

close  all; % Ferme  les  figures  ouvertes

clc;         % Efface  la  console



%% Initialisation  des  parametres

fe = 1e4; % Fréquence d’échantillonnage
Te = 1/fe; % Période d’échantillonnage
Ns=5000; % nombre de symboles par paquet
Ts = 1e-3 ;% Temps symbole
Fse = Ts/Te ;% Facteur de upsampling
fs =1/Ts; % Fréquence symbole
f0 = 2500;
A = 1 ; % creation du symbole A, fixe à 1.

%% bruit

eb_n0_dB = 0:0.5:10; % Liste  des Eb/N0 en dB

eb_n0     = 10.^( eb_n0_dB /10); % Liste  des Eb/N0

TEB = zeros(size(eb_n0)); % Tableau  des  TEB (resultats)

Pb   = qfunc(sqrt (2* eb_n0)); % Tableau  des  probabilites d'erreurs  theoriques
nbr_paquets=0;
cpt2=0;
for k = 1: length(eb_n0)
    % emetteur
    Sb = randi([0,1],1,Ns);
    nb_err = 0 ;
    nb_pckt = 0;
    while nb_err <= 100
        nb_pckt = nb_pckt + 1;

        for i = 1:Ns
            
            if Sb(i) == 1
                Ss(i) = A;
            else
                Ss(i) = -A;
                
            end
            
        end
        Fse = 10 ;
        
        Ssu= upsample(Ss,Fse);
        g(1:1:10)=1;
        ga= g;
        Sl = conv(g, Ssu);
        
        %% Bruit gaussien         
        energie_b = sum(abs(g).^2)/eb_n0(k)/2;
        nl =  sqrt(energie_b)*randn(1,length(Sl));
        yl =  nl + Sl;
        
        %% Recepteur
        rl = conv(ga, yl);
        rln = rl(length(g):Fse:length(rl)-length(g)) ;

        % decision
        for i = 1:Ns
            if rln(i) < 0
                An(i) = -A;
            else
                An(i) = A;
            end
        end
        
        %symbole à bits
        for i = 1:Ns
            if An(i) == A
                Sb2(i) = 1;
            elseif An(i) == -A
                Sb2(i) = 0;
            end
        end
        cpt = 0 ;
        for j = 1:1:length(Sb)
            if Sb2(j) ~= Sb(j)
                cpt = cpt +1;
                nb_err = nb_err+1 ;
            end
        end
    end
    TEB(k) = nb_err / (Ns*nb_pckt);
    
end

%% Affichage  des  resultats
semilogy(eb_n0_dB, TEB);
hold on;
semilogy(eb_n0_dB, Pb);
hold off;
     eyediagram(rln(Fse:1000),Fse,3*Ts);
     t=0:Te:(50*Ts-Te);
    
     figure
     plot(t,Sl(1:500))
     title('Allure de Sl(t)');
     xlabel('t(s)');
     ylabel('Sl(t)');
     
     figure;
     plot(t,rl(1:500))
     title('Allure de rl(t)');
     xlabel('t(s)');
     ylabel('rl(t)');
     
          figure;
     plot(t,Ss(1:500))
     title('Allure de Ss(t)');
     xlabel('t(s)');
     ylabel('Ss(t)');
     
M=512;
[DSP_e, f] = pwelch(Sl,M,0,2*M,fs,'centered');
semilogy(f,abs(DSP_e));
title('DSP expérimentale');
