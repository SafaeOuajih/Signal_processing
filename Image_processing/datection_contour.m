clear
close all
A=double(imread('cameraman.tif'));
figure, imshow(uint8(A),gray(256))

sigma=1.5;
[X,Y]=meshgrid(-5:5);
Hx=-X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
Hy=-Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));
Gx=conv2(A,Hx,'same');
Gy=conv2(A,Hy,'same');
G=(Gx.*Gx+Gy.*Gy).^0.5;
figure, imshow(G, [0 1000]);
colormap(flipud(gray(256)))