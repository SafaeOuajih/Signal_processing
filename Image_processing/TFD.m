clear, close all

A=imread('building.jpg');
figure, image(A)
colormap(gray(256))
[h,w]=size(A);
B=log10(abs(fft2(A)));
fx=linspace(0,1-1/w,w);
fy=linspace(0,1-1/h,h);
figure, imagesc(fx,fy,B);
colormap(jet(256))
% si w et h pairs
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
figure
imagesc(fx,fy,fftshift(B));

colormap(jet(256))