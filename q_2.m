clc;
clear all;
close all;

I=imread('house.tif');
img=I(:,:,1);
Y=fft2(img);
figure(1),
subplot(1,2,1),imshow(log(abs(Y)),[]),title('Fourier transform');
Z=fftshift(Y);
subplot(1,2,2),imshow(log(abs(Z)),[]),title('shift the result of Fourier transform');

 % (b) 
img = im2single(I(:,:,1));
img_f = imgaussfilt(img,3);
[m,n] = size(img_f);
resample_rate = 2;
img_resample = img_f(1:resample_rate:m,1:resample_rate:n);
B = imresize(img_resample, [m,n]);

figure(2); 
subplot(1,2,1),imshow(img_f),title('original image');
subplot(1,2,2),imshow(B),title('1:2 resample');

error_rate = 0;
for i = 1:m
    for j = 1:n
        error_rate = error_rate + img(i,j) - B(i,j);
    end
end
error_rate = abs(error_rate)/256