%%COMPOSANTES HAUTE FRÉQUENCE SUR UN SIGNAL ÉCHANTILLONNÉ À BASSE FRÉQUENCE : DÉBRUITAGE D’UN SIGNAL BIOMÉDICAL
%% récuperation des echantillons du fichier biomed.mat
load('biomed.mat');

% tracé du signal 
figure(1);
plot(signal);

% calcul de la période 
T= 1/fe;
N = 5120;
n = [0 : 1 : N - 1];
ns = [-N/2 : 1 : N/2 - 1]
t = n.*(T/N);
f = ns .*(fe/N)
% tracé du signal en fonction du temps 
figure(2);
plot(t,signal);
% fréquence max pouvant être représentée 

%affichage TFD 
S = fft (signal ,N); 
Sshift = fftshift(abs(S));
figure(3);
plot(n,abs(S));
figure(4);
plot(f,abs(Sshift));

% tracé du signal bruité en fonction du temps 
figure(5);
plot(t,signal_b);
% fréquence max pouvant être représentée 

%affichage TFD du signal bruité
Sb = fft (signal_b ,N); 
Sbshift = fftshift(abs(Sb));
figure(6);
plot(n,abs(Sb));
figure(7);
plot(f,abs(Sbshift));
% Signal sinusoidale de fréqence f0 = 49,9 Hz
% Signal à éliminer en HF , filtre pas -bas , RIF 
f0 = 49,9;
A = 1;
B = [1 , -2*cos(2*pi*(f0/fe)) , 1];
figure(11);
[h1,h2] = zplane(B,A);

% filtrage maison su signal 
y = filter(B,A,signal_b);
figure(8);
plot(t,y);

Y = fft(y,N);
figure(9);
plot(n,abs(Y));
