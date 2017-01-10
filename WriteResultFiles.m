function WriteResultFiles(fileName,truePoints,noisePointsAll)

    resultFile = [fileName '_TrueSurface.txt'];
    noiseFile = [fileName '_Noise.txt'];

    resultFileID = fopen(resultFile,'w');
    for i = 1:1:length(truePoints(:,1))
        fprintf(resultFileID,'%12.5f %12.5f %12.5f %12.5f %12.5f %12.5f %d %12.5f\r\n',...
            truePoints(i,1),truePoints(i,2),truePoints(i,3),truePoints(i,4),truePoints(i,5),...
            truePoints(i,6),truePoints(i,7),truePoints(i,8));
    end
    fclose(resultFileID);

    disp([resultFile ' has been created.'])

    noiseFileID = fopen(noiseFile,'w');
    for i = 1:1:length(noisePointsAll(:,1))
        fprintf(noiseFileID,'%12.5f %12.5f %12.5f %12.5f %12.5f %12.5f %d %12.5f\r\n',...
            noisePointsAll(i,1),noisePointsAll(i,2),noisePointsAll(i,3),noisePointsAll(i,4),...
            noisePointsAll(i,5),noisePointsAll(i,6),noisePointsAll(i,7),noisePointsAll(i,8));
    end
    fclose(noiseFileID);

    disp([noiseFile ' has been created.'])

end

