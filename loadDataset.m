% LOADDATASET Loads the full dataset (from local directory faces-data) into
%  memory and stores it as a set of integral images and label vectors
%  Note, negative images are labeled 0 in the code (and not -1 as in the slides)
function [x,y] = loadDataset(MAX_N_PERCLASS)

iPfiles = dir('./faces-data/Face16/*pgm');
nPfiles = min(MAX_N_PERCLASS,length(iPfiles));
t = double(imread(fullfile(['./faces-data/Face16/'],iPfiles(1).name)))/255.;
[h,w] = size(t);
iNfiles = dir('./faces-data/Nonface16/*pgm');
nNfiles = min(MAX_N_PERCLASS,length(iNfiles));

nFiles = nPfiles+nNfiles;
y = zeros(nFiles,1);
y(1:nPfiles) = 1;
y(nPfiles+1:nPfiles+nNfiles) = 0;

x = zeros(h,w,nFiles);

c=1;

for i=1:nPfiles
    im = double(imread(fullfile(['./faces-data/Face16/'],iPfiles(i).name)))/255.;
    x(:,:,c) = integralImage(im);
    c = c + 1;
end

for i=1:nNfiles
    im = double(imread(fullfile(['./faces-data/Nonface16/'],iNfiles(i).name)))/255.;
    x(:,:,c) = integralImage(im);
    c = c + 1;
end


clear iPfiles iNfiles
