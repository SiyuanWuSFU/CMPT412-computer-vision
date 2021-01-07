

%%%
% To test an image, file name must be manually changed. Padding and subplot 
% must be also manully chosen. 
%%%
layers = get_lenet();
load lenet.mat


%%%%%%%%%%%%%
% This is the section that needs manual modification

pic1 = imread('../images/image1.jpg');  %change image name here
%padding = 100;              % padding for image1-3 
padding = 10;               % padding for image4 

%%%%%%%%%%%%%

pic1 = rgb2gray(pic1);                                                       %change to 2D picture
pic1 = imbinarize(pic1);                                                     % threshholding 
pic1 = imcomplement(pic1);                                                   % Black and white exchange
se = strel('line',1,1);
pic1 = imdilate(pic1,se);
connected = bwconncomp(pic1);
part_num = connected.NumObjects;                                             %getting number of connected parts

    
total_part= bwlabel(pic1,8);                                                 %for differnt part assign a label 
for i = 1: part_num
    
    [r,c] = find(total_part == i);
    part = [r c];
    total_point = size(part,1);
    

    i_h = max(part(:,1))-min(part(:,1));
    i_w = max(part(:,2))-min(part(:,2));

    if i_h> i_w                                                              %select highest side for new figure dimension
        create_part = zeros([i_h + padding , i_h + padding]);
        row_pad = round(size(create_part,1)/2 - i_h/2);
        col_pad = round(size(create_part,2)/2 - i_w/2);
    else
        create_part = zeros([i_w + padding , i_w + padding]);
        row_pad = round(size(create_part,1)/2 - i_h/2);
        col_pad = round(size(create_part,2)/2 - i_w/2);
    end


    for j = 1:total_point                                                    % plot all point of the number to a new figure
        row_index = part(j,1)-min(part(:,1))+1;
        col_index = part(j,2)-min(part(:,2))+1;
        create_part(row_index+ row_pad,col_index+ col_pad) = 1;              % adding padding 
       

        
    end 
    pic1=imresize(create_part,[28 28]);
    
%%%%%%%%%%%%%
% This is the section that needs manual modification

%    subplot(2,5,i);   %image1
%     subplot(2,5,i);     %image2
%     subplot(2,3,i);    %image2
%     subplot(3,17,i);   %image4    
     
%%%%%%%%%%%%%     
    imshow(pic1)
    
    pic1 = pic1';                                                            %transpose for prediction
    pic1 = reshape(pic1, 28*28, 1);
    [output, P] = convnet_forward(params, layers, pic1);
    [M,number] = max(P);
    result = number-1;
    title(['prediction: ',num2str(result)])


end


