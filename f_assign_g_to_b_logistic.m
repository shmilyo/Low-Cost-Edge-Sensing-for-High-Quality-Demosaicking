function [greenAtB] = f_assign_g_to_b_logistic()
% code by Yan Niu
global bayerImg
global imgHeight
global imgWidth
global greenOddIndex
global greenEvenIndex

greenAtB = NaN(imgHeight/2,imgWidth/2); 
startRow = 4; endRow = imgHeight-2;
startCol = 3; endCol = imgWidth-3;

greenEven = reshape(bayerImg(greenEvenIndex),[imgHeight/2,imgWidth/2]);
greenOdd =  reshape(bayerImg(greenOddIndex),[imgHeight/2,imgWidth/2]);

% linear interpolation at boundaries
greenAtB(1:ceil(startRow/2)-1,:) = 0.5*(greenEven(1:ceil(startRow/2)-1,:)+greenOdd(1:ceil(startRow/2)-1,:));
greenAtB(ceil(endRow/2)+1:end,:) = 0.5*(greenEven(ceil(endRow/2)+1:end,:)+greenOdd(ceil(endRow/2)+1:end,:));
greenAtB(:,1:ceil(startCol/2)-1) = 0.5*(greenEven(:,1:ceil(startCol/2)-1)+greenOdd(:,1:ceil(startCol/2)-1));
greenAtB(:,ceil(endCol/2)+1:end) = 0.5*(greenEven(:,ceil(endCol/2)+1:end)+greenOdd(:,ceil(endCol/2)+1:end));

% estimate the non-boundary positions
greenAtBNoBoundary = f_interp_flat_logistic(bayerImg,1,...
                                            startRow,endRow,startCol,endCol);
greenAtB(ceil(startRow/2):ceil(endRow/2),ceil(startCol/2):ceil(endCol/2))= greenAtBNoBoundary;