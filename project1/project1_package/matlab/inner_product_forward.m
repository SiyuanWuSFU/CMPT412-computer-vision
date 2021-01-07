function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
%fprintf('%i\n', d);

k = size(input.data, 2);
%fprintf('%i\n', k);

n = size(param.w,2);
%fprintf('%i\n', n);



%fprintf('%d ', size(param.w));
%fprintf('%d ', size(input.data));
%fprintf('%d ', size(param.b));
% Replace the following line with your implementation.
output.data = zeros([n, k]);


for i=1:k
    data = input.data(:,i);
    %fprintf('%d ', size(data));
    output.data(:,i) = (data'*param.w + param.b)' ;

output.height = input.height;
output.width =  input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

%fprintf(' %d ', size(output.data));


end
