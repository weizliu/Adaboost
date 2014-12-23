clear
clc
load H
[X,Y] = loadDataset(N);  % assume we get all pos and then all neg
n = length(Y);
x = X(:,:,1:2:end);  %half data for training
y = Y(1:2:end);

s = [size(x,1),size(x,2)];
f = H.f_t(1:5);
SHOWFILTERS( s, f )