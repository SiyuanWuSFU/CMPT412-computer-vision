%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% % Modify the code to get the confusion matrix

% % P is predict percentage
% % ytest is the actual number

for i=1:100:size(xtest, 2)
   
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [M,number] = max(P);
    figure
    cm = confusionchart(ytest(:, i:i+99),number);   
end


%%%
%Below are code for testing real images
% myFolder = '../data';
% filePattern = fullfile(myFolder, '*.jpg'); 
% theFiles = dir(filePattern);
% real_picture = zeros([10, 12]);
% real_result = [5,8,9,0,3,4,3,1,6,7,6,1];
% predicition = zeros([1, 12]);
% 
% for k = 1 : 12
%     baseFileName = theFiles(k).name;
%     fullpath = fullfile(theFiles(k).folder, baseFileName);
%     fprintf(1, 'Reading %s\n', fullpath);
%     pic1 = imread(fullpath);
% 
%     pic1 = double(pic1)/255;
%     pic1 = rgb2gray(pic1);
%     %pic1 = imcomplement(pic1);  % Black and white exchange
%     pic1=imresize(pic1,[28 28]);
%     
%     subplot(3,4,k) ;
%     imshow(pic1);  %display image
% 
%     pic1 = pic1';
%     pic1 = reshape(pic1, 28*28, 1);
%     [output, P] = convnet_forward(params, layers, pic1);
%     real_picture(:,k) = P;
%     [M,number] = max(P);
%     result = number-1;
%     predicition(:,k) = result;
%     title(['prediction: ',num2str(result)])
% end
% %%%
