function[avgSCIELAB] = f_scielab(im1,im2)
sampPerDeg = 23;
load displaySPD;
load SmithPokornyCones;
rgb2lms = cones'* displaySPD;
load displayGamma;
rgbWhite = [1 1 1];
whitepoint = rgbWhite * rgb2lms';

normalizedIm1 = 1/256.0*im1;
normalizedIm2 = 1/256.0*im2;

reshapedIm1 = [normalizedIm1(:,:,1) normalizedIm1(:,:,2) normalizedIm1(:,:,3)];
reshapedIm2 = [normalizedIm2(:,:,1) normalizedIm2(:,:,2) normalizedIm2(:,:,3)];

dacIm1 = dac2rgb(reshapedIm1,gammaTable);
lmsIm1 = changeColorSpace(dacIm1,rgb2lms);
dacIm2 = dac2rgb(reshapedIm2,gammaTable);
lmsIm2 = changeColorSpace(dacIm2,rgb2lms);

imageformat = 'lms';
errorImg = scielab(sampPerDeg, lmsIm1, lmsIm2, whitepoint, imageformat);
avgSCIELAB = mean(errorImg(:));
