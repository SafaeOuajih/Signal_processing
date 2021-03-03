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
A = 1 % creation du symbole A, fixe à 1.

%% Emetteur
    %% generation signal binaire
    Sb = randi([0,1],1,Ns); % initialisation du signal a emettre
    %% Bit => Symbole 
    for i = 1:Ns %pour chaque valeur du signal dans le tableau
        if Sb(i) == 1 % si la valeur du bit est egal a 1
            Ss(i) = A; % on associe le symbole +A
        else % sinon
            Ss(i) = -A; % on associe le symbole -A
        end
    end

    Ssu=upsample(Ss,Fse);
    g(1:1:10)=1; % on remplace les dix premiers zeros par des 1 pour obtenir l'expression du filtre de mise en forme
    Sl = conv(g, Ssu); % le signal Sl est la convolution entre le flitre de mise en forme et le signal de sortie de l'emetteur.   
%% Recepteur
ga= g; % ga(t) = g*(Tg - t)
rl = conv(ga, Sl); % le signal Sl est le resultat de la convolution entre le signal recu et le filtre de reception.
rl = rl/10;% on remet le signal a niveau (celui-ci etant monte en valeur lors des convolutions)
rl2 = rl(1:Fse:length(rl)); % Down sampling

% decision 
for i = 1:Ns %pour chaque valeur dans le tableau rl2
 if rl2(i) <= 0 %si cette valeur est plus petite que 0
   An(i) = -A; %on associe le symbole -A
 else %sinon
   An(i) = A; %on associe le symbole +A
 end
end

%symbole vers bits
for i = 1:Ns % pour chaque symbole dans le tableau
 if An(i) == A % si le symbole est A
   Sb2(i) = 1; % le bit correspondant est 1
 elseif An(i) == -A % sinon si le symbole est -A
   Sb2(i) = 0; % le bit correspondant est 0
 end
end

%calcul du taux d'erreur binaire
nbr_err = 0;
for i = 1:Ns % pour chaque symbole
  if Sb(i) ~= Sb2(i)
    nbr_err=nbr_err+1;
  end  
end
TEB = nbr_err/Ns;

%% Affichage  des  resultats
     eyediagram(rl(Fse:1000),3*Fse,3*Ts);
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
     
        [DSP_e,f] = pwelch(Sl,Ns);
        semilogy(f,abs(DSP_e));
        title('DSP');
        xlabel('f');
        ylabel('DSP');
