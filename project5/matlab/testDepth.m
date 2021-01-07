clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

maxDisp = 20; 
windowSize = 3;
dispM = get_disparity(im1, im2, maxDisp, windowSize);

[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;

% imshow(rectIR)


size(im1);
rectIL = imcrop(rectIL,[445  0 480 640]);


% imshow(rectIL)
% figure;

rectIR = imcrop(rectIR,[40  0 480 640]);
% imshow(rectIR)

size(rectIL);
size(rectIR);
dispM_r = get_disparity(rectIL, rectIR, maxDisp, windowSize);

% --------------------  get depth map

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);
depthM_r = get_depth(dispM_r, K1n, K2n, R1n, R2n, t1n, t2n);

% --------------------  Display

figure;
imagesc(dispM.*(im1>40)); colormap(gray); axis image;
title('disparity map-no rectify')  
figure;
 imagesc(depthM.*(im1>40)); colormap(gray); axis image;
title('depth map-no rectify')  
figure;
imagesc(dispM_r.*(rectIL>40)); colormap(gray); axis image;
title('disparity map- rectify')  
figure;
 imagesc(depthM_r.*(rectIL>40)); colormap(gray); axis image;
title('depth map- rectify')  