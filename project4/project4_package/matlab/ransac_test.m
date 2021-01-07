cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_img, desk_img);
[ bestH2to1, inliers] = computeH_ransac( locs1, locs2);


inliers
RGB = insertMarker(cv_img,inliers,'size',10);
imshow(RGB)
figure();

locs1(1,:)





pt = [inliers.'; ones(1, size(inliers, 1))];
out2 = (inv(bestH2to1) * pt).';
out2 = bsxfun(@rdivide, out2(:,1:2), out2(:,3));

showMatchedFeatures(cv_img, desk_img, inliers, out2, 'montage')
