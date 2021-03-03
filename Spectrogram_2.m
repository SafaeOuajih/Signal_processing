load('biomedC1.mat');
%figure(1);
%plot(signal);
%% calcul de la période 
T= 1/fs;
N = 8368;
n = [0 : 1 : N - 1];
ns = [-N/2 : 1 : N/2 - 1]
t = n*T;
f = n*(fs/N)
fs2 = ns *(fs/N)

%% tracé du signal en fonction du temps 
figure(1);
plot(t,signal);

%% tracé du fft du signal
X = fft(signal , N) 
Xm = abs(X)
figure(2);
plot(f,Xm);
figure(5);
plot(fs2,fftshift(Xm))

%% signal bruité
figure(3);
plot(t,signal_b);
    % tracé du fft du signal_b
Xb = fft(signal_b , N) 
Xmb = abs(Xb)
figure(4);
plot(f,Xmb);
plot(fs2,fftshift(Xmb))

%% filtrage
f0 = 90;
A = 1;
B = [1, -2*cos(2*pi*(f0/fs)), 1];
y = filter(B,A,signal_b);
figure(6);
plot(t,y);
Y = fft(y,N);
figure(9);
plot(f,abs(Y));

%% erreur quadratique moyenne

s1= sum(signal)/N
sb1= sum(signal_b)/N
e1= abs(s1-sb1)

y2=sum(y)/N
e2= abs(s1-y2)

