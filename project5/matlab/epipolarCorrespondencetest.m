M = load('../data/someCorresp.mat','M');
pts1_struct = load('../data/someCorresp.mat','pts1');
pts2_struct = load('../data/someCorresp.mat','pts2');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
value = getfield(M,'M');
pts1 = getfield(pts1_struct,'pts1');
pts2 = getfield(pts2_struct,'pts2');
F = eightpoint(pts1, pts2, value);

[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);