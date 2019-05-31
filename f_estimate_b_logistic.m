function[fullBlue] = f_estimate_b_logistic(diffColor,fullGreen)
global imgHeight
global imgWidth
global redIndex
global greenOddIndex
global greenEvenIndex
global blueIndex
global bayerImg


diffGB = NaN(imgHeight,imgWidth);
diffGB(blueIndex) = diffColor(blueIndex);

diffGBAtR = f_assign_gb_to_r_logistic(diffColor);
diffGB(redIndex) = diffGBAtR;

diffGBAtGOdd = f_assign_color_diff_to_g_odd_logistic(diffGB);
diffGB(greenOddIndex) = diffGBAtGOdd;

diffGBAtGEven = f_assign_color_diff_to_g_even_logistic(diffGB);
diffGB(greenEvenIndex) = diffGBAtGEven;

fullBlue = fullGreen-diffGB;
minBlue = min(bayerImg(blueIndex));
maxBlue = max(bayerImg(blueIndex));
fullBlue = min(max(fullBlue,minBlue),maxBlue);
