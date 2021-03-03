[s,fc]=audioread('parole1.wav');
% création signal parasite
fb = 0.2 * fc;
n = [0 : 1 : 53247];
nshift = [(-53248/2)  : 1 : (53248/2 -1)];
fshift = nshift .*(fc/53248);
sb = (1/26)*cos(2*pi*0.2*n);

% mise au carré de chaque élément
s_c= s.*s;
sb_c=sb.*sb;
% création signal bruité 
x = s + sb';


%calcul de la puissance 
Ps = sum(s_c);

Pe = sum(sb_c);

RSB = 10*log(Ps/Pe);
%visualisation spectrogramme 
figure(1);
spectrogram(x,256,0,256,fc);

% tf signal bruité + affichage 
S = fft(s,53248);
figure(2);
plot(n,S);

X = fft(x,53248);
X(10600:10700)=0;
X(42500:42700)=0;


figure(3);
plot(n,X);

% on centre la tf en 0 en frequence
Xshift = fftshift(X);
figure(4);
plot(fshift,Xshift);

% fft inverse pour retrouver s
s1 = ifft(X,53248);
spectrogram(s1,256,0,256,fc);
%soundsc(s,fc);

% debruitage par filtrage selectif
r = 1;
a = 1;
b = [ 1 , -2*r*cos(2*pi*(fb/fc)), r*r];

[H,W]=freqz(b,a,256,'whole');
figure(5);
plot(W,abs(H)); 

y = filter(b,a,x);
figure(6);
spectrogram(y,256,0,256,fc);
