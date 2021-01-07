% A test script using templeCoords.mat
%
% Write your code here
%

% save extrinsic parameters for dense reconstruction
clear;
load('../data/someCorresp.mat')
load('../data/intrinsics.mat')
I1 = imread('../data/im1.PNG');
I2 = imread('../data/im2.PNG');
F = eightpoint(pts1, pts2, M);
load('../data/templeCoords.mat')
num = size(pts1,1);

for i = 1:size(pts1,1)
    [pts2] = epipolarCorrespondence(I1, I2, F, pts1(i,:));
    pts2_t(i,:) = pts2;
end


load('../data/intrinsics.mat')

E = essentialMatrix(F,K1,K2) 
P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0] ;
candidates  = camera2(E);


for i = 1:4
    
 P = triangulate(K1*P1, pts1, K2*candidates(:,:,i), pts2_t);
     if all(P(3,:) > 0)
        final_P = P;
        M2 = candidates(:,:,i);
    end
end
R1=P1(:,1:3);
t1=P1(:,4);
R2=M2(:,1:3);
t2=M2(:,4);

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
plot3(final_P(1,:),final_P(2,:),final_P(3,:),'.');
axis equal
