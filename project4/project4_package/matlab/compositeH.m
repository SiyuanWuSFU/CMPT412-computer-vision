function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);

%% Create mask of same size as template
composite_img = img;

mask = ones(size(template,1),size(template,2),3);

%imshow(H_template_to_img*template)

%% Warp mask by appropriate homography
mask = warpH(mask, H2to1, size(img));
%imshow(mask);
%figure()
%% Warp template by appropriate homography
new_template = warpH(template, H2to1, size(img));
size(mask);
size(composite_img);
%% Use mask to combine the warped template and the image
for i=1:size(mask,1)
    for j=1:size(mask,2)
        if mask(i,j) ~= 0;   
          composite_img(i,j,:) =[255;255;255] ;
        end

    end
end
for i=1:size(composite_img,1)
    for j=1:size(composite_img,2)
        if composite_img(i,j,:) == [255;255;255]    
            composite_img(i,j,:) = new_template(i,j,:);
          
        end

    end
end

end