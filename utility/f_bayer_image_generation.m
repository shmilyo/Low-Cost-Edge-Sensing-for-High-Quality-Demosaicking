function [bayerImg,redSet,blueSet,greenOddSet,greenEvenSet] = f_bayer_image_generation(originalImg)
% code by Yan Niu
%origianlImg: the original image
%bayerImg: the bayer pattern of the original image
% The bayer pattern we use: 
%G R G R G R
%B G B G B G
global imgHeight
global imgWidth

redSet = false(imgHeight,imgWidth);
redSet(1:2:end-1,2:2:end) = true(imgHeight/2,imgWidth/2);

blueSet = false(imgHeight,imgWidth);
blueSet(2:2:end,1:2:end-1) = true(imgHeight/2,imgWidth/2);

greenOddSet = false(imgHeight,imgWidth);
greenOddSet(1:2:end-1,1:2:end-1) = true(imgHeight/2,imgWidth/2);

greenEvenSet = false(imgHeight,imgWidth);
greenEvenSet(2:2:end,2:2:end) = true(imgHeight/2,imgWidth/2);

bayerImg = NaN(imgHeight,imgWidth);
bayerImg(1:2:end,1:2:end) = originalImg(1:2:end,1:2:end,2);%green channel at odd grid coordinates
bayerImg(2:2:end,2:2:end) = originalImg(2:2:end,2:2:end,2);%green channel at even grid coordinates
bayerImg(1:2:end,2:2:end) = originalImg(1:2:end,2:2:end,1);%red channel
bayerImg(2:2:end,1:2:end) = originalImg(2:2:end,1:2:end,3);%blue channel

