function [truePoints,noisePointsAll] = CleanFunction(rotatedCoords,borders,mainArray,tolerance)

    for i = 1:1:length(borders(:,1))
        pointsFromInside = find(rotatedCoords(:,1) > borders(i,1) & ...
            rotatedCoords(:,2) > borders(i,2) & ...
            rotatedCoords(:,1) <= borders(i,3) & ...
            rotatedCoords(:,2) > borders(i,4) & ...
            rotatedCoords(:,1) <= borders(i,5) & ...
            rotatedCoords(:,2) <= borders(i,6) & ...
            rotatedCoords(:,1) > borders(i,7) & ...
            rotatedCoords(:,2) <= borders(i,8));

        selectedArray = mainArray(pointsFromInside,:);

        if (isempty(selectedArray))
            selectedArray = [];
            noisePoints = [];
        else

            regressX = rotatedCoords(pointsFromInside,1);
            regressY = rotatedCoords(pointsFromInside,2);
            regressCriteria = [ones(size(regressX)) ...
                regressX.^2 ...
                regressX ...
                regressY.^2 ...
                regressY ...
                regressX.*regressY];

            regressCoeff = regress(selectedArray(:,3),regressCriteria);
            trueZ = zeros(size(regressX));

            for j = 1:1:length(regressX)
                trueZ(j,1) = regressCoeff(1) ...
                  + regressCoeff(2)*regressX(j)^2 ...
                  + regressCoeff(3)*regressX(j) ...
                  + regressCoeff(4)*regressY(j)^2 ...
                  + regressCoeff(5)*regressY(j) ...
                  + regressCoeff(6)*regressX(j)*regressY(j);
            end

            differenceObsTrue = selectedArray(:,3) - trueZ;
            noisePoints = [];
            emptyFindArray = 0;

            while emptyFindArray ~= 1
                if std(differenceObsTrue) > tolerance
                    stdDev = std(differenceObsTrue);
                else
                    stdDev = 3*std(differenceObsTrue);
                end
                findNoisePointsTrueSurface = find(differenceObsTrue > (mean(differenceObsTrue) + stdDev) | ...
                    differenceObsTrue < (mean(differenceObsTrue) - stdDev));
                emptyFindArray = double(isempty(findNoisePointsTrueSurface));
                noisePoints = [noisePoints;selectedArray(findNoisePointsTrueSurface,:)];
                selectedArray(findNoisePointsTrueSurface,:) = [];
                differenceObsTrue(findNoisePointsTrueSurface,:) = [];
            end

        end

        if (i == 1)
            truePoints = [];
            truePoints = [truePoints;selectedArray];
            noisePointsAll = [];
            noisePointsAll = [noisePointsAll;noisePoints];
        else
            truePoints = [truePoints;selectedArray];
            noisePointsAll = [noisePointsAll;noisePoints];
        end
    end
    disp('Noise has been removed.')
    
end

