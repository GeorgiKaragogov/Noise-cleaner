function rotatedCoords = RotateCoordinates(mainArray)

    xCoord = mainArray(:,1);
    yCoord = mainArray(:,2);
    heading = (270-mainArray(:,4))/(180/pi);

    rotationAngle = mean(heading);

    rotCoordX = zeros(size(xCoord));
    rotCoordY = zeros(size(yCoord));


    for i = 1:1:length(xCoord)
        rotCoordX(i) = xCoord(i)*cos(rotationAngle) - yCoord(i)*sin(rotationAngle);
        rotCoordY(i) = xCoord(i)*sin(rotationAngle) + yCoord(i)*cos(rotationAngle);
    end
    rotCoordX = rotCoordX - fix(min(rotCoordX) - 100);
    rotCoordY = rotCoordY - fix(min(rotCoordY) - 100);
    rotatedCoords = [rotCoordX,rotCoordY];

end

