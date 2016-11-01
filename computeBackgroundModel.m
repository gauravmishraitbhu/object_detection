function backgroundModel = computeBackgroundModel(images)

firstImage = images{2};
[rows,cols,depth] = size(firstImage);
sumImage = zeros(rows,cols,depth);
for i=3:numel(images)
    sumImage = sumImage + im2double(images{2});
end

backgroundModel = sumImage/numel(images);

