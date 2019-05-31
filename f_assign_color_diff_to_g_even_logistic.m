function[diffInterAtGEven] = f_assign_color_diff_to_g_even_logistic(diffInter)
% code by Yan Niu
global imgWidth
global imgHeight
global redIndex
global blueIndex

 
diffInterAtGEven = NaN(imgHeight/2,imgWidth/2);
diffInterAtR = reshape(diffInter(redIndex),[imgHeight/2,imgWidth/2]);
diffInterAtB = reshape(diffInter(blueIndex),[imgHeight/2,imgWidth/2]);

startRow = 6; endRow = imgHeight-6; startCol = 6; endCol = imgWidth-4;

% linear interpolation for values at boundary positions
diffInterAtGEven(1:ceil(startRow/2)-1,:)  = 0.5*(diffInterAtR(1:ceil(startRow/2)-1,:)+...
    diffInterAtB(1:ceil(startRow/2)-1,:));
diffInterAtGEven(ceil(endRow/2)+1:end,:)  = 0.5*(diffInterAtR(ceil(endRow/2)+1:end,:)+...
    diffInterAtB(ceil(endRow/2)+1:end,:));
diffInterAtGEven(:,1:ceil(startCol/2)-1)  = 0.5*(diffInterAtR(:,1:ceil(startCol/2)-1)+...
    diffInterAtB(:,1:ceil(startCol/2)-1));
diffInterAtGEven(:,ceil(endCol/2)+1:end)  = 0.5*(diffInterAtR(:,ceil(endCol/2)+1:end)+...
    diffInterAtB(:,ceil(endCol/2)+1:end));

% estime the values at central positions
diffInteAtGEvenNoBoundary = f_interp_flat_logistic(diffInter,2,...
                                                   startRow,endRow,startCol,endCol);
diffInterAtGEven(ceil(startRow/2):ceil(endRow/2), ceil(startCol/2):ceil(endCol/2))  = diffInteAtGEvenNoBoundary;