function[diffInterAtGOdd] = f_assign_color_diff_to_g_odd_logistic(diffInter)
% code by Yan Niu
% input:
% diffInter: inter-channel difference. Its values at the red and blue
% positions have been restored;

global imgWidth
global imgHeight
global redIndex
global blueIndex

diffInterAtGOdd = NaN(imgHeight/2,imgWidth/2);
diffInterAtR = reshape(diffInter(redIndex),[imgHeight/2,imgWidth/2]);
diffInterAtB = reshape(diffInter(blueIndex),[imgHeight/2,imgWidth/2]);

startRow = 5; endRow = imgHeight-5; startCol = 5; endCol = imgWidth-5;

% linear interpolation at the boundary positions
diffInterAtGOdd(1:ceil(startRow/2)-1,:)  = 0.5*(diffInterAtR(1:ceil(startRow/2)-1,:)+...
    diffInterAtB(1:ceil(startRow/2)-1,:));
diffInterAtGOdd(ceil(endRow/2)+1:end,:)  = 0.5*(diffInterAtR(ceil(endRow/2)+1:end,:)+...
    diffInterAtB(ceil(endRow/2)+1:end,:));
diffInterAtGOdd(:,1:ceil(startCol/2)-1)  = 0.5*(diffInterAtR(:,1:ceil(startCol/2)-1)+...
    diffInterAtB(:,1:ceil(startCol/2)-1));
diffInterAtGOdd(:,ceil(endCol/2)+1:end)  = 0.5*(diffInterAtR(:,ceil(endCol/2)+1:end)+...
    diffInterAtB(:,ceil(endCol/2)+1:end));

%compute the interior region
diffInterAtGOddNoBoundary = f_interp_flat_logistic(diffInter,2,...
                                                   startRow,endRow,startCol,endCol);
diffInterAtGOdd(ceil(startRow/2):ceil(endRow/2), ceil(startCol/2):ceil(endCol/2))  = diffInterAtGOddNoBoundary;