function [imagePatch]  = getImagePatch(Image , patchCenter , patchSize)

imageRows = size(Image , 1);
imageCols = size(Image , 2);
numChannels = size(Image , 3);
patchSize = ceil(patchSize);
width = patchSize;
height = patchSize;
centerRow = patchCenter(1);
centerCol = patchCenter(2);

startRow = ceil(centerRow - height / 2);
endRow = startRow + height;

startCol = ceil(centerCol - width/2);
endCol = startCol + width;
if numChannels > 1
    imagePatch = zeros(height , width , 3);
else
    imagePatch = zeros(height , width);
end
for row = 1:height
    for col = 1:width
        if startRow + row > 0 && startRow + row <= imageRows && ...
                startCol + col > 0 && startCol + col <= imageCols
            if numChannels > 1
                imagePatch(row , col , :) = Image(startRow + row , startCol + col , :);
            else
                imagePatch(row , col) = Image(startRow + row , startCol + col);
            end
        end
    end
end


function [imagePatch] = getInterpolatedImage(Image , patchCenter , patchSize)
width = patchSize;
height = patchSize;
centerRow = patchCenter(1);
centerCol = patchCenter(2);
startRow = centerRow - height / 2;
endRow = startRow + height;
startCol = centerCol - width / 2;
endCol = startCol + width;

y = startRow:endRow;
x = startCol:endCol;
[X,Y]=meshgrid(x,y);
Image = double(Image);
imagePatch = interp2(Image,X,Y);