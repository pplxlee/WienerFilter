close all
clc;
clear;

setParam

load IMGPMean

pictureDir = ['../../TestPictures/', keyWord, 'Resize/'];
pictureDirInfo  = dir([pictureDir, '*jpg']);
pictureNum = length(pictureDirInfo);

pictureDirName = [pictureDir, pictureDirInfo(20).name];
img = imread(pictureDirName);
img = im2double(img);

sigmaGauss = 100;
% sigmaGauss = 0;

% h = fspecial('motion');
h = fspecial('disk',5) ;
% h=ones(5,5)/25;

h1 = zeros(size(img));
xxx = 502;
x1 = 10;
x2 = 10;
h1(xxx:xxx+x1,xxx:xxx+x2,1) = h;
h1(xxx:xxx+x1,xxx:xxx+x2,2) = h;
h1(xxx:xxx+x1,xxx:xxx+x2,3) = h;
% h1(1:5,1:5,1) = h;
% h1(1:5,1:5,2) = h;
% h1(1:5,1:5,3) = h;
H = fft2(h1);
Habs = abs(H);

IMGF = fft2(img).*H;
imgF = ifft2(IMGF);
% imgF=imfilter(img,h);

imgGauss = imnoise(imgF,'gaussian',0,(sigmaGauss/255).^2); %gauss

% n = imgGauss-img;
% imgGauss = uint8(double(img)+n);
% h1 = zeros(size(img));
% h1(1:5,1:5,1) = h;
% h1(1:5,1:5,2) = h;
% h1(1:5,1:5,3) = h;

% WIENER = 1/(1+ (sigmaGauss/255).^2./IMGPMean);
WIENER = conj(H)./(Habs.^2+ (sigmaGauss/255).^2./IMGPMean);

% WIENER = 1;
fImgGauss = fft2(imgGauss);
imgWiener = ifft2(fImgGauss.*WIENER);
% imgWiener = uint8(ifft2(fImgGauss));

% [imgWiener(:,:,1),k(1) ]= wiener2(imgGauss(:,:,1),[8 8]);
% [imgWiener(:,:,2),k(2) ]= wiener2(imgGauss(:,:,2),[8 8]);
% [imgWiener(:,:,3),k(3) ]= wiener2(imgGauss(:,:,3),[8 8]);
% k

figure;
% subplot 131
imshow(img);
% subplot 132
figure;
imshow(abs(imgGauss))
% subplot 133
figure;
imshow(abs(imgWiener),[])
