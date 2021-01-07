function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1; %h_out = 24
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%fprintf('%d \n', size(param.w));
%fprintf('%d \n', size(input.data));
%fprintf('%d \n', size(param.b));


for i = 1: size(input.data,2)
    
    in.data = input.data(:,i);
    %fprintf('%d \n', size(input.data,2))
    in.height = h_in;
    in.width = w_in;
    in.channel = c;

    Xcol = im2col_conv(in,layer,h_out,w_out);
    %fprintf('%d \n', size(Xcol));
    Xcol = reshape(Xcol, k*k*c, h_out*w_out);

    %fprintf('%d \n', size(Xcol));
    %fprintf('%d \n', size(param.b));
    %fprintf('%d \n', size(param.w));
 
    temp(:,1:num) = Xcol' * param.w + param.b;
   
    output.data(:,i)  =  temp(:);
    %fprintf('%d \n', size(output.data(:,i)));

end
%output.data
%fprintf('%d \n', size( output.data));
output.height = h_out;
output.width =  w_out;
output.channel = num;
output.batch_size = batch_size;
%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 


end

