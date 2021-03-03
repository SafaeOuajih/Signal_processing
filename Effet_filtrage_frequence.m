% création signal de 3 sinusoïdes sur 256 échantillons 
n = [0:1:255];
x = cos(2*pi*(4/256)*n) +cos(2*pi*(32/256)*n) + cos(2*pi*(124/256)*n) ;

%création du signal filtré
a1 = [1 , -1/3],
b1 = [1/3 , 1/3],
y1 = filter (b1,a1,x);

a2 = [1 , -1/3],
b2 = [2/3 , -2/3],
y2 = filter (b2,a2,x);

% création de la TFD + affichage

X = fft (x,256);
Y1 = fft (y1,256);
Y2 = fft (y2, 256);

figure(1) ;
plot (n,x,n,y1);

figure(2);
plot (n,x,n,y2);

figure(3);
plot (n,X);

figure(4);
plot (n,Y1); % on observe ici que que le filtre est un passe-haut (conserve les HF)

figure(5);
plot (n,Y2); % on observe que le filtre est un passe-bas

% affichage de la réponse fréquentielle 
[H1,W1]=freqz(b1,a1,256,'whole');
[H2,W2]=freqz(b2,a2,256,'whole');

figure(6)
plot(W1,abs(H1)); 

figure(7)
plot(W2,abs(H2)); 
