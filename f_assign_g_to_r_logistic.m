function [greenAtR] = f_assign_g_to_r_logistic()
% code by Yan Niu
global bayerImg
global imgHeight
global imgWidth
global greenEvenIndex
global greenOddIndex

 greenAtR = NaN(imgHeight/2,imgWidth/2);    
 startRow = 3; endRow = imgHeight-3;
 startCol = 4; endCol = imgWidth-2;
 
 % The values at boundary positions are filled by linear
 % interpolation.
greenEven = reshape(bayerImg(greenEvenIndex),[imgHeight/2,imgWidth/2]);
greenOdd =  reshape(bayerImg(greenOddIndex),[imgHeight/2,imgWidth/2]);

greenAtR(1:ceil(startRow/2)-1,:) = 0.5*(greenEven(1:ceil(startRow/2)-1,:)+greenOdd(1:ceil(startRow/2)-1,:));
greenAtR(ceil(endRow/2)+1:end,:) = 0.5*(greenEven(ceil(endRow/2)+1:end,:)+greenOdd(ceil(endRow/2)+1:end,:));
greenAtR(:,1:ceil(startCol/2)-1) = 0.5*(greenEven(:,1:ceil(startCol/2)-1)+greenOdd(:,1:ceil(startCol/2)-1));
greenAtR(:,ceil(endCol/2)+1:end) = 0.5*(greenEven(:,ceil(endCol/2)+1:end)+greenOdd(:,ceil(endCol/2)+1:end));

% estimate the non-boundary positions
greenAtRNoBoundary = f_interp_flat_logistic(bayerImg,1,startRow,endRow,startCol,endCol);
greenAtR(ceil(startRow/2):ceil(endRow/2),ceil(startCol/2):ceil(endCol/2))= greenAtRNoBoundary;



