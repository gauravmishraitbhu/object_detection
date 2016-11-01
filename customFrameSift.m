image1 = imread('img0002.jpg');
I = single(rgb2gray(image1)) ;
[r c bands] = size(image1);
h=figure(1);
imshow(image1);
hold on;
objectCount = 0;

title('Click the top left corner of an object to track...');
[x1 y1] = ginput(1);
x1 = ceil(x1);
y1 = ceil(y1);
plot(x1, y1, 'rx');
title(sprintf('Click the bottom right corner (Right click indicates last object)'));
[x2 y2 button] = ginput(1);
x2 = ceil(x2);
y2 = ceil(y2);
objectCount = objectCount+1;
rectangle('Position', [x1 y1 x2-x1 y2-y1], 'LineWidth', 4, 'EdgeColor', [1 0 0]);

frame = [ (x1 + x2)/2 ; (y1+y2)/2 ; max(x2-x1 , y2-y1) ; 0];

rectWidth = round((x2-x1));
rectHeight = round(y2-y1);

prevX = x1;
prevY = y1;
prevImage = image1;

% [f,d] = vl_sift(I,'frames',frame) ;

[f,d] = vl_sift(I( ceil(y1):ceil(y2) , ceil(x1):ceil(x2)));

for i=3:600
    fileName = strcat('img' , sprintf('%04d' , i) , '.jpg');
    completePath = '/Users/gaurav/Vision/TrackingDataset/BoBot/Vid_A_ball/';
    completePath = strcat(completePath , fileName);
    image2 = imread(completePath);
    [maxRows , maxCols , ~] = size(image2);
    Ib = single(rgb2gray(image2)) ;
    diffImage = image2-prevImage;
    minX = ceil(prevX - rectWidth/2);
    if minX <1
        minX = 1;
    end
    maxX = ceil(prevX + rectWidth + rectWidth);
    if maxX > maxCols
        maxX = maxCols;
    end

    minY = ceil(prevY - rectHeight/2);
    if minY < 1
        minY = 1;
    end
    maxY = ceil(prevY + rectHeight + rectHeight);
    if(maxY > maxRows)
        maxY = maxRows;
    end

    [fb , db] = vl_sift(Ib(minY:maxY , minX : maxX));


    [matches  scores] = vl_ubcmatch(d , db , 1.5);

    imshow(image2);
    hold on;

    if size(matches) >=1 
        bestMatchIndexes = matches(2,:);
        for matchNum = 1:size(bestMatchIndexes)
            bestMatchIndex = bestMatchIndexes(matchNum);
             centerX = fb(1,bestMatchIndex) + minX;
             centerY = fb(2,bestMatchIndex) + minY;
             prevX = ceil(centerX - rectWidth/2);
             prevY = ceil(centerY - rectHeight/2);
             prevX = round(prevX);
             prevY = round(prevY);
             if prevY+rectHeight > size(diffImage , 1) || prevX+rectWidth > size(diffImage,2)
                 continue;
             end
             window = diffImage(prevY:prevY+rectHeight , prevX:prevX+rectWidth);
             isBackground = isBackgroud( window, 0);
             
             if isBackground == 1
                 continue;
             else
                rectangle('position',[prevX prevY rectWidth rectHeight] , 'EdgeColor' , [1 0 0]);
                fbCurrent = fb(:,bestMatchIndex);
                toAdd = [minX ; minY ; 0 ; 0];
                toAddMat = repmat(toAdd , 1 , size(fbCurrent,2));
                fbCurrent = fbCurrent + toAddMat;
                vl_plotframe(fbCurrent);

                imageFrame=getframe(gca);
                [X, map] = frame2im(imageFrame);

                imwrite(X,strcat('output/',fileName),'jpeg');
                break;
             end
            
         end
    end
    prevImage = image2;
end



