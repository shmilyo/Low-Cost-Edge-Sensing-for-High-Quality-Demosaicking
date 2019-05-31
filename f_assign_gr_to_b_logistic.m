function[grAtB] = f_assign_gr_to_b_logistic(diffInter)
% code by Yan Niu
global imgWidth
global imgHeight

grAtB = NaN(imgHeight/2,imgWidth/2);

startRow = 4; endRow  = imgHeight-2; startCol = 3; endCol = imgWidth-3;

% nearest neighbour interpolation to estimate boundary position values
grAtB(1:ceil(startRow/2)-1,:) = diffInter(1:2:2*ceil(startRow/2)-2,2:2:end);
grAtB(ceil(endRow/2)+1:end,:) = diffInter(2*ceil(endRow/2)+1:2:end,2:2:end);
grAtB(:,1:ceil(startCol/2)-1) = diffInter(1:2:end,2:2:2*ceil(startCol/2)-2);
grAtB(:,ceil(endCol/2)+1:end) = diffInter(1:2:end,2*ceil(endCol/2)+2:2:end);


%recover the interior region
grAtBNoBoundary = f_interp_diag_logistic(diffInter,...
                                         startRow,endRow,startCol,endCol);
grAtB(ceil(startRow/2):ceil(endRow/2), ceil(startCol/2):ceil(endCol/2))  = grAtBNoBoundary;