layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')
figure 

%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));

output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1,1}.data, 28, 28);
layertwo = output{1,2}.data ;
layerthree = output{1,3}.data ;
nmax = max(layertwo(:,1));
nmin = min(layertwo(:,1));

size(layerthree(:,1)');
size(layertwo(:,1)');
layer_normal = output{1,3}.data ;

layer_normal = (layer_normal-nmin)/(nmax-nmin);

splittwo = reshape(layertwo(:,1),24,24,20) ;            %resize
splitthree = reshape(layerthree(:,1),24,24,20) ;
splitnorm = reshape(layer_normal(:,1),24,24,20);

for i = 1:20            %data after conv layer
    subplot(4,5,i) ;
    imshow(splittwo(:,:,i)')
    
end
figure


for j = 1:20             %data after RELU layer
    subplot(4,5,j) ;
    imshow(splitthree(:,:,j)')
    
end
figure
for k = 1:20         %data normalized data for RELU layer    
    subplot(4,5,k) ;
    
    imshow(splitnorm(:,:,k)')
    
end

% [output, P] = convnet_forward(params, layers, xtest(:, 1));
% [M,number] = max(P);
% number
% % Fill in your code here to plot the features.
% imshow(output_1)
% figure