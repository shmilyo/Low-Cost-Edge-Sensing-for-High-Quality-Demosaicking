function [estimateG] = f_estimate_g_logistic()
% code by Yan Niu
% output: the recovered G channel
global bayerImg
global imgHeight
global imgWidth
global greenOddIndex
global greenEvenIndex
global redIndex
global blueIndex


estimateG = NaN(imgHeight,imgWidth);
estimateG(greenOddIndex) = bayerImg(greenOddIndex);
estimateG(greenEvenIndex) = bayerImg(greenEvenIndex);
maxLevel = max(estimateG(:),[],'omitnan');
minLevel = min(estimateG(:),[],'omitnan');

estimateGatR = f_assign_g_to_r_logistic;
estimateG(redIndex) = estimateGatR;

estimateGatB = f_assign_g_to_b_logistic;
estimateG(blueIndex) = estimateGatB;

estimateG = min(max(estimateG,minLevel),maxLevel);
