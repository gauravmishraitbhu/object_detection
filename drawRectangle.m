function [updatedImage] = drawRectangle(image , center , rectSize)

[imageRows , imageCols , ~] = size(image);
rectStartRow = uint8(ceil(center(1) - rectSize/2));
rectStartCol = uint8(ceil(center(2) - rectSize/2));
thickness = 2;

%draw top line
for row = rectStartRow: rectStartRow + thickness
    for col = rectStartCol: rectStartCol + rectSize
        if row >= 1 && row <= imageRows && col >=1 && col <= imageCols
            image(row , col , 1) = 255;
            image(row , col , 2) = 0;
            image(row , col , 3) = 0;
        end
    end
end

%draw left line
for row = rectStartRow : rectStartRow + rectSize
    for col = rectStartCol : rectStartCol + thickness
        if row >= 1 && row <= imageRows && col >=1 && col <= imageCols
            image(row , col , 1) = 255;
            image(row , col , 2) = 0;
            image(row , col , 3) = 0;
        end
    end
end

%draw bottom line
for row = rectStartRow + rectSize : rectStartRow + rectSize + thickness
    for col = rectStartCol : rectStartCol + rectSize
        if row >= 1 && row <= imageRows && col >=1 && col <= imageCols
            image(row , col , 1) = 255;
            image(row , col , 2) = 0;
            image(row , col , 3) = 0;
        end
    end
end

%draw right line
for row = rectStartRow : rectStartRow + rectSize
    for col = rectStartCol + rectSize : rectStartCol + rectSize + thickness
        if row >= 1 && row <= imageRows && col >=1 && col <= imageCols
            image(row , col , 1) = 255;
            image(row , col , 2) = 0;
            image(row , col , 3) = 0;
        end
    end
end
updatedImage = image;