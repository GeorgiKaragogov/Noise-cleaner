function borders = Borders(rotatedCoords,areaSize)

    northBorder = max(rotatedCoords(:,2)) + 0.1;
    southBorder = min(rotatedCoords(:,2)) - 0.1;
    eastBorder = max(rotatedCoords(:,1)) + 0.1;
    westBorder = min(rotatedCoords(:,1)) - 0.1;

    horDist = eastBorder - westBorder;
    vertDist = northBorder - southBorder;

    vertAmount = fix(vertDist/areaSize);
    horAmount = fix(horDist/(vertDist/vertAmount)) + 1;

    horBoxSize = horDist/horAmount;
    vertBoxSize = vertDist/vertAmount;
    amountAreas = vertAmount*horAmount;
    borders = zeros(amountAreas,8);

    i = 0;
    for k = 1:1:vertAmount
        for j = 1:1:horAmount
            i = i + 1;
            borders(i,1) = westBorder + (j-1)*horBoxSize;
            borders(i,2) = southBorder + (k-1)*vertBoxSize;
            borders(i,3) = westBorder + j*horBoxSize;
            borders(i,4) = southBorder + (k-1)*vertBoxSize;
            borders(i,5) = westBorder + j*horBoxSize;
            borders(i,6) = southBorder + k*vertBoxSize;
            borders(i,7) = westBorder + (j-1)*horBoxSize;
            borders(i,8) = southBorder + k*vertBoxSize; 
        end
    end

end

