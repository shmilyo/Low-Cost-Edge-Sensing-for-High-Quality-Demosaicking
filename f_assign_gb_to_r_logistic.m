function[gbAtR] = f_assign_gb_to_r_logistic(diffInter)

global imgWidth
global imgHeight

gbAtR = NaN(imgHeight/2,imgWidth/2);


startRow = 3; endRow = imgHeight-3; startCol = 4; endCol = imgWidth-2;


%nearest neighbour interpolation for values at the boundary positions
gbAtR(1:ceil(startRow/2)-1,:) = diffInter(2:2:2*ceil(startRow/2)-1,1:2:end);
gbAtR(ceil(endRow/2)+1:end,:) = diffInter(2*ceil(endRow/2)+2:2:end,1:2:end);
gbAtR(:,1:ceil(startCol/2)-1) = diffInter(2:2:end,1:2:2*ceil(startCol/2)-2);
gbAtR(:,ceil(endCol/2)+1:end) = diffInter(2:2:end,2*ceil(endCol/2)+2:2:end);

%estimate the values at the central region
gbAtRNoBoundary = f_interp_diag_logistic(diffInter,...
                                         startRow,endRow,startCol,endCol);
gbAtR(ceil(startRow/2):ceil(endRow/2), ceil(startCol/2):ceil(endCol/2))  = gbAtRNoBoundary;