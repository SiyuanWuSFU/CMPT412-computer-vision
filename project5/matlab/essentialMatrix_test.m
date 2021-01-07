M = load('../data/someCorresp.mat','M');
pts1_struct = load('../data/someCorresp.mat','pts1');
pts2_struct = load('../data/someCorresp.mat','pts2');
K1_struct = load('../data/intrinsics.mat','K1');
K2_struct = load('../data/intrinsics.mat','K2');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
value = getfield(M,'M');
pts1 = getfield(pts1_struct,'pts1');
pts2 = getfield(pts2_struct,'pts2');

K1 = getfield(K1_struct,'K1');
K2 = getfield(K2_struct,'K2');
F = eightpoint(pts1, pts2, value)
E = essentialMatrix(F, K1, K2)

scale = [1/value 0 0; 0 1/value 0; 0 0 1];
E = scale'*E*scale

[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, E);