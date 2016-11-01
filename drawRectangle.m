function [updatedImage] = drawRectangle(image , center , size)

rectStartRow = ceil(center(1) - size/2);
rectStartCol = ceil(center(2) - size/2);
thickness = 2;

%draw top line
for row = rectStartRow: rectStartRow + thickness
    for col = rectStartCol: rectStartCol + size
        image(row , col , 1) = 255;
        image(row , col , 2) = 0;
        image(row , col , 3) = 0;
    end
end

%draw left line
for row = rectStartRow : rectStartRow + size
    for col = rectStartCol : rectStartCol + thickness
        image(row , col , 1) = 255;
        image(row , col , 2) = 0;
        image(row , col , 3) = 0;
    end
end

%draw bottom line
for row = rectStartRow + size : rectStartRow + size + thickness
    for col = rectStartCol : rectStartCol + size
        image(row , col , 1) = 255;
        image(row , col , 2) = 0;
        image(row , col , 3) = 0;
    end
end

%draw right line
for row = rectStartRow : rectStartRow + size
    for col = rectStartCol + size : rectStartCol + size + thickness
        image(row , col , 1) = 255;
        image(row , col , 2) = 0;
        image(row , col , 3) = 0;
    end
end
updatedImage = image;