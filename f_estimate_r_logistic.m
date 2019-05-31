function[fullRed] = f_estimate_r_logistic(diffColor,fullGreen)
%code by Yan Niu
%input:
%diffColor: the difference between two color channels
%fullGreen: the restored green channel
%output:
%fullRed: the interpolated red channel

global imgHeight
global imgWidth
global redIndex
global greenOddIndex
global greenEvenIndex
global blueIndex
global bayerImg

diffGR = NaN(imgHeight,imgWidth);
diffGR(redIndex) = diffColor(redIndex);

diffGRAtB = f_assign_gr_to_b_logistic(diffColor);
diffGR(blueIndex) = diffGRAtB;

diffGRAtGOdd = f_assign_color_diff_to_g_odd_logistic(diffGR);
diffGR(greenOddIndex) = diffGRAtGOdd;

diffGRAtGEven = f_assign_color_diff_to_g_even_logistic(diffGR);
diffGR(greenEvenIndex) = diffGRAtGEven;

fullRed = fullGreen-diffGR;
minRed = min(bayerImg(redIndex));
maxRed = max(bayerImg(redIndex));
fullRed = min(max(fullRed,minRed),maxRed);