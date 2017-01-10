clear;
clc;

fileDir = uigetfile({'*.txt'},'Open point cloud txt file');
[~,fileName,~] = fileparts(fileDir);
disp(['Uploading ',fileDir,' ...'])
mainArray = load(fileDir);
disp([fileDir,' has been uploaded.'])

tolerance = 0.02;
areaSize = 5;

rotatedCoords = RotateCoordinates(mainArray);
borders = Borders(rotatedCoords,areaSize);

disp('Detecting noise ...')
[truePoints,noisePointsAll] = CleanFunction(rotatedCoords,borders,mainArray,tolerance);

disp('Writing result files ...')
WriteResultFiles(fileName,truePoints,noisePointsAll);

disp('Computation has been finished.')