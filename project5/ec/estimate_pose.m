function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
A = [];
x1=x';
X1=X';

  for i=1:size(x1, 1)    
    x = x1(i, 1);
    y = x1(i, 2);
    X = X1(i, 1);
    Y = X1(i, 2);
    Z = X1(i, 3);
    
    A = [
      A; 
      X, Y, Z, 1, 0, 0, 0, 0, -x*X, -x*Y, -x*Z, -x; 
      0, 0, 0, 0, X, Y, Z, 1, -y*X, -y*Y, -y*Z, -y  
    ];

  end
  % compute smallest singular value
  size(A);
  [~,~,V] = svd(A);        
  smallest = V(:,size(V,2));      
  P = [smallest(1:4)'
      smallest(5:8)'
      smallest(9:12)']; 
end