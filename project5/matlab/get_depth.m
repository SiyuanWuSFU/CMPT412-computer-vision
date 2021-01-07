function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

[row, col] = size(dispM);
depthM = ones(row,col);

depthM=1./(dispM) ;
depthM(depthM==Inf)= 0 ;

c1 = -(inv(R1))*t1 ;
c2 = -(inv(R2))*t2 ;

b = (sum((c1-c2).*(c1-c2)))^0.5 ;
f = K1(1,1) ;
size(b*f);
size(dispM);

depthM = b*f*depthM ;

end