[s,fe]=audioread('lettreC1.wav');
d= (300-1)/9000

%% tfd du signal M =512
M= 512
S = fft(s,M)
Sm= abs(S)
n = [0 : 1 : M - 1];
f = n*(fe/512)
figure(1)
plot(f, Sm)

%% TFD DU signal M = 2000
M2= 2000
S2 = fft(s,M2)
n2 = [0 : 1 : M2 - 1];
f2 = n2 .*(fe/512)
Sm2= abs(S2)
figure(2)
plot(f2, Sm2)


%% centrer le spectre en 0
ns = [-M/2 : 1 : M/2 - 1]
Ss = fftshift(Sm)
fs = ns*(fe/512)
figure(3)
plot(fs, Ss)

%% construction de g 
k=[0:1:299]
x1= cos(2*pi*k*(800/fe))
x2= cos(2*pi*k*(700/fe))
x3= x1 + x2
X = fft(x3,M)

Xm= abs(X)
figure(4)
plot(f, Xm)

Xs = fftshift(Xm)
figure(5)
plot(fs, Xs)
%%
[s2,fe2]=audioread('motC1.wav');
N = 1200
spectrogram(s2,300,0,400,fe2);





