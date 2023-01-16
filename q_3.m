%% 3
clc;
clear all; 
close all;

I_ori=imread('gonzalezwoods725.PNG')
img = rgb2gray(I_ori);

[n,m] = size(img);
N = 4;
A = zeros(N,N);
B = zeros(N,N);
for i = 0:3
    if i == 0
        alpha = sqrt(1/N);
    else
        alpha = sqrt(2/N);
    end
    for n = 0:3
        A(n+1,i+1) = alpha*cos(i*pi*(2*n+1)/(2*N));
        B(n+1,i+1) = exp(-1i*2*pi*i*n/N);
    end
end
% dct
figure(1);
i = 1;
for p = 1:4
    for q = 1:4
        dct_basis = A(:,p)*A(:,q)';
        subplot(4,4,i), imagesc(dct_basis); colormap(gray);                   
        i = i+1;
    end
end


% dft
figure(2);
i = 1;
for p = 1:4
    for q = 1:4
        dft_basis = B(:,p)*B(:,q)';
        dft_basis_r = real(dft_basis)-imag(dft_basis);
        subplot(4,4,i),imagesc(dft_basis_r); colormap(gray);
        i = i+1;
    end
end


D=dct2(img);
B=fft2(img);
F=fftshift(B)
figure(3);
subplot(1,3,1),imshow(D),title('DCT transformation');
subplot(1,3,2),imshow(log(abs(B)),[]),title('DFT transformation');
subplot(1,3,3),imshow(log(abs(F)),[]),title('shift the result of DFT transformation');