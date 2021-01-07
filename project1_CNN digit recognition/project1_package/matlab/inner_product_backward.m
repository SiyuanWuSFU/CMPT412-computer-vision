function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));

param_grad.b = sum(output.diff');
param_grad.w = input.data*(output.diff');
input_od = param.w*output.diff; 
end
