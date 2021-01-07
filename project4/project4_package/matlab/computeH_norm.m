function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points


centroid1 = mean(x1(:,1:2));
centroid2 = mean(x2(:,1:2));

%% Shift the origin of the points to the centroid

x1(:,1) = x1(:,1) - centroid1(1);
x1(:,2) = x1(:,2) - centroid1(2);
x2(:,1) = x2(:,1) - centroid2(1);
x2(:,2) = x2(:,2) - centroid2(2);


%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
average1 = mean(sqrt(x1(1,:).^2 + x1(2,:).^2));
average2 = mean(sqrt(x2(1,:).^2 + x2(2,:).^2));
scale1 = sqrt(2)/average1;
scale2 = sqrt(2)/average2;
x1 = x1*scale1;
x2 = x2*scale2;

%% similarity transform 1
T1 = [scale1 0  -scale1*centroid1(1);0 scale1 -scale1*centroid1(2);0 0 1];
%% similarity transform 2
T2 = [scale2 0  -scale2*centroid2(1);0 scale2 -scale2*centroid2(2);0 0 1];

%% Compute Homography
[ H ] = computeH( x1, x2 );
%% Denormalization
H2to1 = inv(T2)*H*T1; 
