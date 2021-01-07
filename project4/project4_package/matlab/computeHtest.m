cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_img, desk_img);
%n = size(locs1,1);
%centroid1 = mean(locs1(:,1:2));
%centroid1(1);
x = size(cv_img,1);
y = size(cv_img,2);
random_point = zeros(10,2);

random_point(:,1) = randi([1,y],1,10);
random_point(:,2) = randi([1,x],1,10);


RGB = insertMarker(cv_img,random_point,'size',10);
imshow(RGB)
figure();

locs1(1,:)

[ H ] = computeH_norm( locs1, locs2 );      %test  computeH
%[ H ] = computeH( locs1, locs2 );          %test  computeH_norm



pt = [random_point.'; ones(1, size(random_point, 1))];
out2 = (H * pt).';
out2 = bsxfun(@rdivide, out2(:,1:2), out2(:,3));

showMatchedFeatures(cv_img, desk_img, random_point, out2, 'montage')