% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cv_img = imread('../data/cv_cover.jpg');
if size(cv_img,3)==3
    cv_img = rgb2gray(cv_img);
end
%% Compute the features and descriptors
feature1 = detectFASTFeatures(cv_img);
[descriptor1, locs1] = computeBrief(cv_img,feature1.Location);

his = [];
count = 0;



% for i = 0:35
%     %% Rotate image
%     
%     J = imrotate(cv_img,i*10);
%     %% Compute features and descriptors
%     feature2 = detectFASTFeatures(J);
%     [descriptor2, locs2] = computeBrief(J,feature2.Location);
% 
%     %% Match features
%      match = matchFeatures(descriptor1,descriptor2,'MatchThreshold',10);
%      match_point1=locs1(match(:,1),:);
%      match_point2=locs2(match(:,2),:);   
%      count = size(match,1);
%         
%      his(end+1) = count;     
%      if i == 1
%         showMatchedFeatures(cv_img, J, match_point1, match_point2, 'montage')    
%         figure()
%      end
%      if i == 25
%         showMatchedFeatures(cv_img, J, match_point1, match_point2, 'montage')    
%         figure()
%      end
%      if i == 17
%         showMatchedFeatures(cv_img, J, match_point1, match_point2, 'montage')    
%         figure()
%      end
% end
% his
% bar(his);
% %% Display histogram
% shg






for i = 0:35
    %% Rotate image
    
    J_SURF = imrotate(cv_img,i*10);
    %% Compute features and descriptors

    
    feature2_surf = detectSURFFeatures(cv_img); 
    [descriptor2_surf, locs2_surf] = extractFeatures(J_SURF, feature2_surf,'Method', 'SURF'); 
    %% Match features

     match = matchFeatures(descriptor1_surf,descriptor2_surf,'MatchThreshold',10);
     count = size(match,1)
        
     his(end+1) = count;
     bar(his);
     
     match_point1=locs1_surf(match(:,1),:);
     match_point2=locs2_surf(match(:,2),:);
     if i == 1
        showMatchedFeatures(cv_img, J_SURF, match_point1, match_point2, 'montage')    
        figure()
     end
     if i == 25
        showMatchedFeatures(cv_img, J_SURF, match_point1, match_point2, 'montage')    
        figure()
     end
     if i == 17
        showMatchedFeatures(cv_img, J_SURF, match_point1, match_point2, 'montage')    
        figure()
     end

    %% Update histogram
end
shg