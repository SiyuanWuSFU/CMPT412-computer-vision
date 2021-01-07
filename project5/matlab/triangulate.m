function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

p_size = size(pts1,1);
p = [pts1'; ones(1,p_size)];
p_2 = [pts2'; ones(1,p_size)];

for i = 1:p_size
    A1 = [0 p(3,i) -p(2,i)      %y*p3 -p2
        -p(3,i) 0 p(1,i)];        %p1 - x*p3

    
    A2 = [0 p_2(3,i) -p_2(2,i)
        -p_2(3,i) 0 p_2(1,i)];

    
    A = [A1*P1
        A2*P2];                 % concatenate
    [U,S,V] = svd(A);
    
    point = V(:, end);
    
    p3d(:,i) = point/point(4);  %normalized
end

pts3d = p3d(1:3,:);

pts_err1 = 0;
pts_err2 = 0;
re_pro1 = P1*p3d;
re_pro2 = P2*p3d;

for j = 1:size(re_pro1,2)
    re_pro1(:,j) = re_pro1(:,j)/re_pro1(3,j);
    re_pro2(:,j) = re_pro2(:,j)/re_pro2(3,j);
    
    single_error1 = sqrt((p(1,j)-re_pro1(1,j)).^2 + (p(2,j)-re_pro1(2,j)).^2 );
    pts_err1 = pts_err1 + single_error1;
    
    single_error2 = sqrt((p_2(1,j)-re_pro2(1,j)).^2 + (p_2(2,j)-re_pro2(2,j)).^2 );
    pts_err2 = pts_err2 + single_error2;
end


pts_err1 = pts_err1/size(re_pro1,2)
pts_err2 = pts_err2/size(re_pro2,2)
