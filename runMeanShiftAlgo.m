
% q - target model
% returns the newCenter of the best candidate model in the given frame
function [newCenter] = runMeanShiftAlgo(image , currentCenter , size , q , kernel)
newCenter = currentCenter;
featureSpace = 1;
% for first iteration compute the target candidate
p = computeWeightedHistogram(image , newCenter ,size ,featureSpace ,kernel);
similarity = 0;
maxIterations = 15;
iterNum = 1;
deltaMod = 9999;
while deltaMod > 1 && iterNum < maxIterations
    weights = computeWeightMatrix(image , newCenter , size , q , p);
    sumWeights = sum(weights(:));
    rowSum = 0;
    colSum = 0;
    patchStartRow = ceil(newCenter(1) - size / 2);
    patchStartCol = ceil(newCenter(2) - size / 2);
    for row = 1:size
        for col = 1:size
            rowSum = rowSum + (patchStartRow+row) * weights(row , col);
            colSum = colSum + (patchStartCol+col) * weights(row , col);
        end
    end

    meanRow = rowSum / sumWeights;
    meanCol = colSum / sumWeights;

    %if delta is less than threshold we can consider the current center as our
    % best candidate
    deltaRow = meanRow - newCenter(1);
    deltaCol = meanCol - newCenter(2);

    deltaMod = sqrt(deltaRow^2 + deltaCol^2);
    %meanX and meanY becomes our new center
    newCenter = [ meanRow  meanCol];
    %compute the  new candidate model prob distribution
    p = computeWeightedHistogram(image , newCenter ,size,featureSpace );
    similarity = computeSimilarity(q,p,48);
    iterNum = iterNum + 1;
end

if iterNum == maxIterations
    disp('max iteratins reached---similarity==');
    disp(similarity);
end