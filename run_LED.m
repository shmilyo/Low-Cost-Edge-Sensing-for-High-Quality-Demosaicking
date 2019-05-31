% Code by Yan Niu for TIP paper "Low Cost Edge Sensing for High Quality Demosaicking"
function [] = run_LED(testImgsPath)
% run this function test our algorithm on your RGB images 
% input: the path to your test images.e.g. '.\data\MRKodak\'
close all
clc

addpath('.\utility');
addpath('.\utility\scielab1-1-1');

global imgHeight
global imgWidth

global kLogistic
kLogistic = 0.05;

global originalImg
global bayerImg
global redIndex
global blueIndex
global greenOddIndex
global greenEvenIndex
exclude = 4;

imgFiles = dir(testImgsPath);
imgFiles = imgFiles(~[imgFiles.isdir]);
numImages = numel(imgFiles); 

resultNew = NaN(numImages,7);
%dataSetName = 'Kodak';
%xlswrite(strcat(dataSetName,'_result_new.xlsx'),resultNew);

for dataID = 1:numImages
    disp(['processing image '  num2str(dataID) ':'])
    %read an image and get its size
    imgFileName = [testImgsPath imgFiles(dataID).name];
    try
        originalImg = double(imread(imgFileName));
    catch
        warning(['file', num2str(dataID), 'cannot be read properly']);
        break;
    end

    originalImg = originalImg(1:floor(end/2)*2,1:floor(end/2)*2,:);
    [imgHeight,imgWidth] = size(originalImg(:,:,1));
     %GR
     %BG
    [bayerImg,redIndex,blueIndex,greenOddIndex,greenEvenIndex] = f_bayer_image_generation(originalImg);
    [demosaicImg] = f_estimate_by_New();
    
    %use for timing
    f = @() f_estimate_by_New();
    resultNew(dataID,7) = timeit(f);
    
    %evaluation
    [PSNRARR,SSIM,SCIELAB] = f_compare_imgs(demosaicImg, originalImg,exclude);
    
    resultNew(dataID,1:4) = PSNRARR(:)';
    resultNew(dataID,5) = SSIM;
    resultNew(dataID,6) = SCIELAB;
end
fprintf( sprintf( '::::: average CPSNR  ::::::::%f\n', mean(resultNew(:,4))) );
fprintf( sprintf( '::::: average SSIM  ::::::::%f\n', mean(resultNew(:,5))) );
fprintf( sprintf( '::::: average SCIELAB  ::::::::%f\n', mean(resultNew(:,6))) );
fprintf( sprintf( '::::: median TIME  ::::::::%f\n', median(resultNew(2:end,7))) );

%resultNew=arrayfun(@(x) sprintf('%10.5f',x),resultNew,'un',0);
%xlswrite(strcat(dataSetName,'_result_new.xlsx'),resultNew);
