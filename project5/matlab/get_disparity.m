function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.


mask = ones(windowSize, windowSize);
[row, col] = size(im1);
disps = zeros(row, col, maxDisp+1);
tmp = zeros(row, col);

for i=0:maxDisp
    dis = 1:(row * (col-i));
 

    size(im1(dis+row*i));
    
    tmp(dis) = (im1(dis + row*i) - im2(dis)).^2;
    size(tmp(dis));
%     if i ==2
%         
%         break
%     end
    disps(:,:,i+1) = conv2(tmp, mask, 'same');
end

[~, inds] = min(disps, [], 3);
dispM = inds - 1;
end