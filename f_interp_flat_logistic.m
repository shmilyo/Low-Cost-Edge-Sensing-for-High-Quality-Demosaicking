function[interpValues] = f_interp_flat_logistic(partValues,flagUseCurvature,...
                                                startRow,endRow,startCol,endCol)
 % code by Yan Niu
 % this function estimates the current value from its the horizontal and vertical neighbours
 % input: 
 %partValues: part of the array have true values;
 %flagUseCurvature: indication of using which differences formula to compute curvature 
 %startRow,endRow,startCol,endCol: the central region that has no boundary
 %problem
 global weightHori
 global weightVert
 
meanHori = 0.5*(partValues(startRow:2:endRow,startCol+1:2:endCol+1)...
         +partValues(startRow:2:endRow,startCol-1:2:endCol-1));
meanVert = 0.5*(partValues(startRow+1:2:endRow+1,startCol:2:endCol)...
         +partValues(startRow-1:2:endRow-1,startCol:2:endCol));
     
curvHori = zeros((endRow-startRow)/2+1,(endCol-startCol)/2+1);
curvVert = zeros((endRow-startRow)/2+1,(endCol-startCol)/2+1);  

if(flagUseCurvature==1)
    curvHori = 0.25*(partValues(startRow:2:endRow,startCol+2:2:endCol+2)...
              +partValues(startRow:2:endRow,startCol-2:2:endCol-2)...
              -2*partValues(startRow:2:endRow,startCol:2:endCol));
    curvVert = 0.25*(partValues(startRow+2:2:endRow+2,startCol:2:endCol)...
              +partValues(startRow-2:2:endRow-2,startCol:2:endCol)...
              -2*partValues(startRow:2:endRow,startCol:2:endCol));  
elseif (flagUseCurvature==2)
    curvHori = 0.125*(partValues(startRow:2:endRow,startCol+3:2:endCol+3)...
              +partValues(startRow:2:endRow,startCol-3:2:endCol-3)...
              -partValues(startRow:2:endRow,startCol+1:2:endCol+1)...
              -partValues(startRow:2:endRow,startCol-1:2:endCol-1));
    curvVert = 0.125*(partValues(startRow+3:2:endRow+3,startCol:2:endCol)...
              +partValues(startRow-3:2:endRow-3,startCol:2:endCol)...
              -partValues(startRow+1:2:endRow+1,startCol:2:endCol)...
              -partValues(startRow-1:2:endRow-1,startCol:2:endCol));   
end

 partWeightHori = weightHori(startRow:2:endRow,startCol:2:endCol);
 partWeightVert = weightVert(startRow:2:endRow,startCol:2:endCol);
 interpValues = partWeightHori.*(meanHori-curvHori)+partWeightVert.*(meanVert-curvVert);

     
     
           