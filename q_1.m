clc;
clear all; 
close all;
%% 1(a)
I1=imread('house.tif');
I1=I1(:,:,1);
I2=imread('lena_gray_256.tif');
L_1=edge(I1,'log');
L1=edge(I1,'log',0.007);
L2=edge(I1,'log',0.01);
C_1=edge(I1,'canny');
C1=edge(I1,'Canny',0.1);
C2=edge(I1,'Canny',0.2);
figure(1);
subplot(2,3,1),imshow(L_1),title('LOG opeartor');
subplot(2,3,2),imshow(L1),title('LOG opeartor 0.007');
subplot(2,3,3),imshow(L2),title('LOG opeartor 0.01');
subplot(2,3,4),imshow(C_1),title('Canny opeator');
subplot(2,3,5),imshow(C1),title('Canny opeator 0.1');
subplot(2,3,6),imshow(C2),title('Canny opeator 0.2');

L_2=edge(I2,'log');
L3=edge(I2,'log',0.007);
L4=edge(I2,'log',0.01);
C_2=edge(I2,'canny');
C3=edge(I2,'Canny',0.1);
C4=edge(I2,'Canny',0.2);
figure(2);
subplot(2,3,1),imshow(L_2),title('LOG opeartor ');
subplot(2,3,2),imshow(L3),title('LOG opeartor 0.007');
subplot(2,3,3),imshow(L4),title('LOG opeartor 0.01');
subplot(2,3,4),imshow(C_2),title('Canny opeator ');
subplot(2,3,5),imshow(C3),title('Canny opeator 0.1');
subplot(2,3,6),imshow(C4),title('Canny opeator 0.2');
% (b)

[row,col]=size(C1);
rhomax=round((row*row+col*col)^0.5);
A=zeros(2*rhomax,180);   %infact,the range of rho is[-rhomax,rhomax]，
                         %but here we exchange to [1,2rhomax] for easy
                         %computation.
 
for m=1:row                        
    for n=1:col
        if C1(m,n)>0 %judge the edges
            for theta=1:180
                r=theta/180*pi; %angle changes
                rho=round(m*cos(r)+n*sin(r));
                %Hough
                rho=rho+rhomax+1;   %cooridintae transformation
                                    
                A(rho,theta)=A(rho,theta)+1;   %count 
            end
        end
    end
end
[rho,theta]=find(A>80);   %threshold
nma=length(rho);

figure(3),imshow(C1)
for i=1:nma
    hold on
    m=1:row;
    r=theta(i)/180*pi;
    n=(rho(i)-rhomax-m*cos(r))/(0.0001+sin(r));
    plot(n,m,'r-','LineWidth',1);
end
title('hough tansformation');

