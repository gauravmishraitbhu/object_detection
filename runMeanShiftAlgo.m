
% q - target model
% returns the newCenter of the best candidate model in the given frame
function [newCenter] = runMeanShiftAlgo(image , currentCenter , size , q)
newCenter = currentCenter;
deltaMod = 99999;
while deltaMod > 2
    %compute the candidate model prob distribution
    p = computeWeightedHistogram(image , currentCenter ,size );

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
    newCenter = [ ceil(meanRow)  ceil(meanCol)];
end
