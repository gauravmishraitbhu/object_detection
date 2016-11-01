function [imagePatch]  = getImagePatch(Image , patchCenter , patchSize)

imageRows = size(Image , 1);
imageCols = size(Image , 2);
patchSize = ceil(patchSize);
width = patchSize;
height = patchSize;
centerRow = patchCenter(1);
centerCol = patchCenter(2);

startRow = ceil(centerRow - height / 2);
endRow = startRow + height;

startCol = ceil(centerCol - width/2);
endCol = startCol + width;
imagePatch = zeros(height , width , 3);
for row = 1:height
    for col = 1:width
        if startRow + row > 0 && startRow + row <= imageRows && ...
                startCol + col > 0 && startCol + col <= imageCols
            imagePatch(row , col , :) = Image(startRow + row , startCol + col , :);
        end
    end
end