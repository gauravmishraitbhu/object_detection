
%q - target model
%p - candidate model
function [weights] =  computeWeightMatrix(image , center , size , q , p)


%loop on all pixels in the given window and compute W matrix
patchSize = ceil(size);
centerRow = center(1);
centerCol = center(2);

patchToConsider = getImagePatch(image , center , size);

weights = zeros(patchSize , patchSize);
redOffset = 0;
greenOffset = 16;
blueOffset = 32;
for row =  1:patchSize
    for col = 1:patchSize
        redValue = patchToConsider(row , col , 1);
        greenValue = patchToConsider(row , col , 2);
        blueValue = patchToConsider(row , col , 3);
         
        [redBinIndex , greenBinIndex , blueBinIndex] = ...
            getColorIndexes(redValue , greenValue , blueValue);
        
        if p(1,redOffset + redBinIndex) == 0
            redContribution = 0;
        else
            redContribution = sqrt( q(1,redOffset + redBinIndex) / p(1,redOffset + redBinIndex) );
        end
        
        if p(1,greenOffset + greenBinIndex) == 0
            greenContribution = 0;
        else
            greenContribution = sqrt( q(1,greenOffset + greenBinIndex) / p(1,greenOffset + greenBinIndex) );
        end
        
        if p(1,blueOffset + blueBinIndex) == 0
            blueContribution = 0;
        else
            blueContribution = sqrt( q(1,blueOffset + blueBinIndex) / p(1,blueOffset + blueBinIndex) );
        end
        
        weights(row,col) = redContribution + greenContribution + blueContribution;
        
    end
end


function [redBinIndex , greenBinIndex  , blueBinIndex] = ...
    getColorIndexes(redValue , greenValue , blueValue)
redBinIndex = ceil(redValue / 16);
if redBinIndex == 0 
     redBinIndex = 1;
end

greenBinIndex = ceil(greenValue / 16);
if greenBinIndex == 0
    greenBinIndex = 1;
end

blueBinIndex = ceil(blueValue / 16);
if blueBinIndex == 0
    blueBinIndex = 1;
end