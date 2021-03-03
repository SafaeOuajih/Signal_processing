clear
close all

A=double(imread('pool.tif'));
R=A(:,:,1);
G=A(:,:,2);
B=A(:,:,3);
Y=0.299*R+0.587*G+0.114*B;
Cb=0.564*(B-Y)+128;
Cr=0.713*(R-Y)+128;
L=(R+G+B)/3;
figure, imshow(uint8(A))
figure, imshow(uint8(L))
figure, imshow(uint8(Y))
tx=90:350;
ty=160:330;
figure,
subplot(2,3,1)
imshow(uint8(R(ty,tx)))
subplot(2,3,2)
imshow(uint8(B(ty,tx)))
subplot(2,3,3)
imshow(uint8(G(ty,tx)))
subplot(2,3,4)
imshow(uint8(Cr(ty,tx)))
subplot(2,3,5)
imshow(uint8(Cb(ty,tx)))
subplot(2,3,6)
imshow(uint8(A(ty,tx,:)))