% EVALUATESLIDING Evaluates an ensemble classifier in a sliding window fashion 
% over an image.
%   B = EVALUATECLASSIFIER( H, I ) evaluates the ensemble classifier H on
%   the image X in a sliding window fashion and returns a bounding boxes 
%   
%   This sliding window iterates over multiple scales
%
%   B is a N x 4 array: N is the number of positive responses,
%      [ upper-left-x upper-left-y width height ; ...]
%



%FINISH CODE
clear
clc
load H_8000_40_l % you need to run train.m first to get H
im = imread('image_of_class.jpg');
%im = imread('forest.jpg');
im_gray = rgb2gray(im);
[height width] = size(im_gray);
   

imshow(im);
%image(im_gray);
hold on

d = 1;
count = 0;
for window_size_x = 50 : 30 : 80 %multiple scales
     window_size_y = window_size_x; %using square window
        step_row =15;
        step_column = 15;
        for row_i = 1 : step_row : height - window_size_y
         for column_i = 1 : step_column : width - window_size_x
            x = im_gray(row_i:row_i+window_size_y,column_i:column_i+window_size_x);
            x = imresize(x,[16 16]);
            x = integralImage(double(x)/255.);
            x_label = evaluateClassifier(H,x);
            count = count + 1;
            if(x_label == 1)
                B(d,:) = [column_i row_i window_size_x window_size_y];
                d = d + 1;
                rectangle('Position',[column_i row_i window_size_x window_size_y],'Linewidth',0.5);
                hold on
            end
         end
      end
   
end
% figure
% imshow(im)
% [idx cen] = kmeans(B,70);
% for i = 1 : 70
%     rectangle('Position',[cen(i,1) cen(i,2) cen(i,3) cen(i,4)],'Linewidth',0.5);
%                 hold on
% end

