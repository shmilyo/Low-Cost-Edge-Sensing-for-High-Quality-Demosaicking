function[interpValues] = f_interp_diag_logistic(partValues,...
                                                startRow,endRow,startCol,endCol)
% code by Yan Niu
global weightDiag
global weightAntiDiag

meanDiag = 0.5*(partValues(startRow+1:2:endRow+1,startCol+1:2:endCol+1)...
         +partValues(startRow-1:2:endRow-1,startCol-1:2:endCol-1));
meanAntiDiag = 0.5*(partValues(startRow-1:2:endRow-1,startCol+1:2:endCol+1)...
             +partValues(startRow+1:2:endRow+1,startCol-1:2:endCol-1));
    
curvDiag = zeros((endRow-startRow)/2+1,(endCol-startCol)/2+1);
curvAntiDiag = zeros((endRow-startRow)/2+1,(endCol-startCol)/2+1);


curvDiag = 2^(-3)*(partValues(startRow+2:2:endRow+2,startCol+2:2:endCol+2)...
                   +partValues(startRow-2:2:endRow-2,startCol-2:2:endCol-2)...
                   -2*partValues(startRow:2:endRow,startCol:2:endCol));
curvAntiDiag = 2^(-3)*(partValues(startRow+2:2:endRow+2,startCol-2:2:endCol-2)...
                       +partValues(startRow-2:2:endRow-2,startCol+2:2:endCol+2)...
                       -2*partValues(startRow:2:endRow,startCol:2:endCol));


partWeightDiag = weightDiag(startRow:2:endRow,startCol:2:endCol);
partWeightAntiDiag = weightAntiDiag(startRow:2:endRow,startCol:2:endCol);
interpValues = partWeightDiag.*(meanDiag-curvDiag)+...
            partWeightAntiDiag.*(meanAntiDiag-curvAntiDiag);
 
    