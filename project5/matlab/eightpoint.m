function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
n = size(pts1, 1);
pts1_scale = pts1 ./ M;
pts2_scale = pts2 ./ M;

x1 = pts1_scale(:, 1);
x2 = pts2_scale(:, 1);
y1 = pts1_scale(:, 2); 
y2 = pts2_scale(:, 2);

%Mx9 matrix A
A = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(n,1)];
%find SVD
[U,S,V] = svd(A);

% F is col with least singular value of V
%V
F = V(:,9);
F = reshape(F,3,3);

%Enforce rank 2 constraint
[U,S,V] = svd(F);
%S
%S(3,3)
S(3,3) = 0;
F = U*S*V';
%unscaling
scale = [1/M 0 0; 0 1/M 0; 0 0 1];
F = scale'*F*scale;
end