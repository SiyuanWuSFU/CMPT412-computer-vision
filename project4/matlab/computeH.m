function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
x1;
x2;
n = size(x1,1);
p = zeros(2*n,9);
if any(isnan(x2(:)))
  x2 = zeros(size(x2,1),size(x2,2));
end
for i = 1:n
    p1 = x1(i, :); 

    p2 = x2(i, :); 

    p(2*i-1, :) = [-p1(1) -p1(2) -1 0 0 0 p2(1)*p1(1) p2(1)*p1(2) p2(1)]; 
    p(2*i, :) = [0 0 0 -p1(1) -p1(2) -1 p2(2)*p1(1) p2(2)*p1(2) p2(2)]; 
    
end

[U, S, V] = svd(p); 

H2to1 = reshape( V(:,end), 3, 3)'; 
end
