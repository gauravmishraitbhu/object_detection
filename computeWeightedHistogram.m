 
% this function will compute weighted histogram of any window which is
% centered at center. this histogram is basically prob distribution of any
% feature space.
% feature space considered is rgb. vector size = 48 . ie we will create 16 bins of r , g,b
% center is a vector of size 2 which has first value as row and 2nd value
% as column.
function [histogram] = computeWeightedHistogram(image , center , patchSize,type , kernel)
 radius = floor(patchSize / 2);
%  kernel = createKernel(patchSize , radius);
 
 % first extract out the patch from the full image to 
 % make calculations of indexes easier

 imageBW = im2bw(image);
 patchToConsider = getImagePatch(image , center , patchSize);
 patchBw = getImagePatch(imageBW ,center , patchSize);
 % now we loop on all pixels of this patch and compute the rgb histograms
 redBins = zeros(1,16);
 greenBins = zeros(1,16);
 blueBins = zeros(1,16);
 intensityBins = zeros(1,16);
 for row = 1:patchSize
     for col = 1:patchSize
         redValue = patchToConsider(row , col , 1);
         greenValue = patchToConsider(row , col , 2);
         blueValue = patchToConsider(row , col , 3);
         intensity = patchBw(row , col);
         [redBinIndex , greenBinIndex , blueBinIndex] = ...
             getColorIndexes(redValue , greenValue , blueValue);
         
         intensityBinIndex = getIntensityIndex(intensity);
         intensityBins(1,intensityBinIndex) = intensityBins(intensityBinIndex) + 1*kernel(row , col);
         redBins(1,redBinIndex) = redBins(redBinIndex) + 1 * kernel(row , col);
         greenBins(1,greenBinIndex) = greenBins(greenBinIndex) + 1 * kernel(row , col);
         blueBins(1,blueBinIndex) = blueBins(blueBinIndex) + 1 * kernel(row , col);
     end
 end
 
 if type == 1
     histogram = horzcat(redBins , greenBins , blueBins);
 elseif type == 2
     histogram = intensityBins;
 end
 histogram = histogram / sum(histogram(:));
 
 
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
        
function [index] = getIntensityIndex(intensity)
index = ceil(intensity / 16);

if index == 0
    index = 1;
end