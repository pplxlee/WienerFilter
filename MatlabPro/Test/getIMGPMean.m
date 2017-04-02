close all
clc;
clear;

setParam
pictureDir = ['../../TestPictures/', keyWord, 'Resize/'];
pictureDirInfo  = dir([pictureDir, '*jpg']);
pictureNum = length(pictureDirInfo);

IMGPMean = zeros(mRow,nCol,3);
for i = 1:pictureNum
    pictureDirName = [pictureDir, pictureDirInfo(i).name];
    img = imread(pictureDirName);
    img = im2double(img);
    [row,col,ch] = size(img);
    IMG = fft2(img);
    IMGP = abs(IMG).^2;
    IMGPMean = IMGPMean + IMGP;
end
IMGPMean = IMGPMean/pictureNum/mRow/nCol;
save IMGPMean IMGPMean