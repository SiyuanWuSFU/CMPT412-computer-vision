function [ match_point1, match_point2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
%%size(I1)
if size(I1,3)==3
    I1 = rgb2gray(I1);
end
if size(I2,3)==3
    I2 = rgb2gray(I2);
end
%% Detect features in both images
feature1 = detectFASTFeatures(I1);
feature2 = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations
[descriptor1, locs1] = computeBrief(I1,feature1.Location);
[descriptor2, locs2] = computeBrief(I2,feature2.Location);

%[feat_1, val_p1] = extractFeatures(I1,feature1); 
%[feat_1, val_p1] = extractFeatures(I2,feature2); 
%% Match features using the descriptors
% size(locs1);
% size(locs2);
% size(descriptor1);
% size(descriptor2);
match = matchFeatures(descriptor1,descriptor2,'MaxRatio',0.78,'MatchThreshold',10);
%match = matchFeatures(descriptor1,descriptor2,'MatchThreshold',10);
%size(match,1);
match_point1=locs1(match(:,1),:);
match_point2=locs2(match(:,2),:);
%showMatchedFeatures(I1, I2, match_point1, match_point2, 'montage')
figure 
end

