%% Gaussian Pyramids
img = imread('lena_gray_256_noisy.png');
% create 3 level G. Pyramid 
level = 2;
gPyrA = gausspyr(img, level);
% show each level of pyramid to test that gausspyr works
 for i = 1:2
     figure;
     imshow(gPyrA{i});
 end
 imgn=gPyrA{1} - expand(gPyrA{2});  
 figure;imshow(imgn); 
 
 % reconstraction
 gPyrA = imresize(gPyrA{2}, 2);
 re_1 = gPyrA+0.005*imgn;
 re_2 = gPyrA+0.5*imgn;
 figure;
 subplot(1,3,1),imshow(re_1);
 subplot(1,3,2),imshow(re_2);
 subplot(1,3,3),imshow(img),title('original image')
