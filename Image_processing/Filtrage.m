clear
close all
A=double(imread('couloir.tif'));
figure, imshow(uint8(A),gray(256))
[h,w]= size(A);
If=fftshift(log10(abs(fft2(A))));
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
figure, imagesc(fx,fy,If)
H1=ones(3)/9;
H2=ones(5)/25;
sigma = 1.5;
[X,Y]= meshgrid(-5:5);
H3 = exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma*sigma);
figure, freqz2(H1);
figure, freqz2(H2);
figure, freqz2(H3);
B=conv2(A,H1,'same');
figure, imshow(uint8(B));
C=medfilt2(A,[5 5]);
figure, imshow(uint8(C));
D=conv2(A,H3,'same');
figure, imshow(uint8(D));
IfB=fftshift(log10(abs(fft2(B))));
figure, imagesc(fx,fy,IfB)
IfC=fftshift(log10(abs(fft2(C))));
figure(20), imagesc(fx,fy,IfC)
IfD=fftshift(log10(abs(fft2(D))));
figure, imagesc(fx,fy,IfD)