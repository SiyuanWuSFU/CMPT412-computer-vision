function [ bestH2to1, final_x] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

data_size = size(locs1,1);
num_iter = 50000;
num_point = 4;
most_inliers = 0;
best_inliers = zeros(1,data_size);
locs1;
for i = 1:num_iter
    current_inliers = zeros(1,data_size);
    
    x = zeros(num_point,2);
    y = zeros(num_point,2);
    
   random_pick = randperm(data_size,num_point);
   for j = 1:num_point
       x(j,:) = locs1(random_pick(j),:);
       y(j,:) = locs2(random_pick(j),:);
   end

    [ H ] = computeH_norm( x, y );
    
    estimate_x = H*[locs1 ones(size(locs1,1),1)]';
    estimate_x =estimate_x./estimate_x(3,:);
    estimate_y = [locs2 ones(size(locs2,1),1)]';
    distance = estimate_x - estimate_y;
    distance = sqrt(distance(1,:).^2 + distance(2,:).^2);

    count = 0;
    for j=1:data_size
        if distance(j) < 0.5
            count = count+ 1;
            current_inliers(j) = 1;
        end
    end

    if count> most_inliers
        most_inliers = count;
        best_inliers = current_inliers;
        best_pick = random_pick;
    end


end
    inliers = best_inliers;
    final_y = locs2(inliers==1,:);
    final_x = locs1(inliers==1,:);    % return this as inliers      
    final_four = locs1(best_pick(1,:),:);   % return this as 4 point pair 
    bestH2to1 = computeH_norm(final_y,final_x);

end


