% Q3.3.1
workingDir = '../data';
[ mov,m_length ] = loadVid( '../data/videoplayback.mp4');
[ book_mov,b_length ] = loadVid( '../data/book.mov');
cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');

book_video = VideoReader('../data/book.mov');



img  = mov(1).cdata;        %remove black bars
width = size(img,2)/2;
side = ceil(size(img,1)/(size(cv_img,1)/size(cv_img,2))/2);

%scaled_img = img(:,width- side:width+ side,:);
 

%imshow(scaled_img)


%b_img  = book_mov(1).cdata;
%imshow(b_img)

%scaled_img =imresize(scaled_img, [size(cv_img,1) size(cv_img,2)]);
%size(scaled_img)
%size(cv_img)
%[locs1, locs2] = matchPics(cv_img, b_img);
%[bestH2to1, ~] = computeH_ransac(locs1, locs2);


%imshow(compositeH(inv(bestH2to1), scaled_img, b_img));



outputVideo = VideoWriter(fullfile(workingDir,'ar_selfmade.mp4'));
outputVideo.FrameRate = book_video.FrameRate;
open(outputVideo)

for ii = 1:b_length
   img = mov(ii+100).cdata;
   scaled_img = img(:,width- side:width+ side,:);
   scaled_img =imresize(scaled_img, [size(cv_img,1) size(cv_img,2)]);
   b_img  = book_mov(ii).cdata;
   [locs1, locs2] = matchPics(cv_img, b_img);

   [bestH2to1, ~] = computeH_ransac(locs1, locs2);
   final_img = compositeH(inv(bestH2to1), scaled_img, b_img);
   writeVideo(outputVideo,final_img)
   ii
end
close(outputVideo)






