function[demosaicImg] = f_estimate_by_New()
% code by Yan Niu
global bayerImg
global imgHeight
global imgWidth
global kLogistic
global weightHori
global weightVert
global weightDiag
global weightAntiDiag
extSize = 2;
%%
%step 1. compute \omega_{h} and \omega_{v} for each pixel, based on the
%original samples.

startRow = extSize+1;endRow = imgHeight + extSize;
startCol = extSize+1;endCol = imgWidth + extSize;

extMosaic = NaN(imgHeight+2*extSize,imgWidth+2*extSize);
extMosaic(startRow:endRow,startCol:endCol) = bayerImg;

gradHori = 0.5*(extMosaic(startRow:endRow,startCol+1:endCol+1)...
               -extMosaic(startRow:endRow,startCol-1:endCol-1));
gradVert = 0.5*(extMosaic(startRow+1:endRow+1,startCol:endCol)...
               -extMosaic(startRow-1:endRow-1,startCol:endCol));
     
curvHori = 0.25*(extMosaic(startRow:endRow,startCol+2:endCol+2)...
          +extMosaic(startRow:endRow,startCol-2:endCol-2)...
          -2*extMosaic(startRow:endRow,startCol:endCol));
curvVert = 0.25*(extMosaic(startRow+2:endRow+2,startCol:endCol)...
          +extMosaic(startRow-2:endRow-2,startCol:endCol)...
          -2*extMosaic(startRow:endRow,startCol:endCol));  
      
diffGrads = abs(gradHori)-abs(gradVert)+2*abs(curvHori)-2*abs(curvVert);
% Weights below are improtant for the demosaicking quality
weightHori = (ones(imgHeight,imgWidth)+exp(diffGrads*kLogistic)).^(-1);
weightVert = ones(imgHeight,imgWidth)-weightHori;

%%
%step 2. compute the diagonal and anti-diagonal weights for all pixels, but
%actually such weights are only needed at (i,j)in R and B.
gradDiag = 2^(-1.5)*(extMosaic(startRow+1:endRow+1,startCol+1:endCol+1)...
               -extMosaic(startRow-1:endRow-1,startCol-1:endCol-1));
gradAntiDiag = 2^(-1.5)*(extMosaic(startRow-1:endRow-1,startCol+1:endCol+1)...
                  -extMosaic(startRow+1:endRow+1,startCol-1:endCol-1));
curvDiag = 2^(-3)*(extMosaic(startRow+2:endRow+2,startCol+2:endCol+2)...
                       +extMosaic(startRow-2:endRow-2,startCol-2:endCol-2)...
                       -2*extMosaic(startRow:endRow,startCol:endCol));
curvAntiDiag = 2^(-3)*(extMosaic(startRow+2:endRow+2,startCol-2:endCol-2)...
                           +extMosaic(startRow-2:endRow-2,startCol+2:endCol+2)...
                           -2*extMosaic(startRow:endRow,startCol:endCol));       
diffGrads = abs(gradDiag)-abs(gradAntiDiag)+2^(1.5)*abs(curvDiag)-2^(1.5)*abs(curvAntiDiag);

 % Weights below are improtant for demosaicking quality of the Red and Blue
 % Channels
 weightDiag = (ones(imgHeight,imgWidth)+exp(diffGrads*kLogistic)).^(-1);
 weightAntiDiag = ones(imgHeight,imgWidth)-weightDiag;
 
%%
%step 1. Recover the green channel
greenByNew=f_estimate_g_logistic;

%the recovery of red and blue can be parallel
diffColor =greenByNew-bayerImg;

redByNew = f_estimate_r_logistic(diffColor,greenByNew);
blueByNew = f_estimate_b_logistic(diffColor,greenByNew);
    
demosaicImg = cat(3,redByNew,greenByNew,blueByNew);






