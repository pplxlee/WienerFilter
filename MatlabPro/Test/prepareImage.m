clear;clc;close all

setParam
% keyWord = 'magazine';
pictureDir = ['../../TestPictures/', keyWord, '/'];
pictureResizeDir = ['../../TestPictures/', keyWord, 'Resize/'];
pictureDirInfo  = dir([pictureDir, '*jpg']);
pictureNum = length(pictureDirInfo);

for i = 1:pictureNum
    pictureDirName = [pictureDir, pictureDirInfo(i).name];
    img = imread(pictureDirName);
    [row,col,ch] = size(img);
    shortEdge = min([row,col]);

    xMin = round((col-shortEdge)/2)+1;
    yMin = round((row-shortEdge)/2)+1;
    imgCrop = imcrop(img, [xMin, yMin, shortEdge, shortEdge]);  %²Ã¼ô

%     mRow = 512;
%     nCol = 512;
    imgResize = imresize(imgCrop,[mRow nCol],'bicubic');
    imshow(imgResize)
    imwrite(imgResize,[pictureResizeDir, num2str(i), '.jpg']);
    pause(0.001)
end

