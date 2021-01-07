function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
pts2 = zeros(size(pts1,1),size(pts1,2));
size(pts1);

x1 = pts1(1,1);
y1 = pts1(1,2);
p1 = [x1; y1; 1];
eline = F*p1;
scale = sqrt(eline(1)^2+eline(2)^2);
eline = eline/scale;

%define window
width = 70;
img_length = size(im2,1);

x2=0;
y2=0;



im1_window = double(im1(y1:y1+width, x1-width:x1+width));



least_error = inf;

for point = 1:img_length
 point;
 xs = round(-(eline(1) * point + eline(3))/eline(2)); 
 if xs-width>0 && xs+width<=size(im2,2)

    im2_window = double(im2(point:point+width,xs -width:xs+width));
    
    current_error = norm(sqrt((im1_window-im2_window).^2));
    if current_error<least_error
        least_error=current_error;
        x2=xs;
        y2=point;
    end
 end
end


pts2(1,1) = x2;
pts2(1,2) = y2;
   

end