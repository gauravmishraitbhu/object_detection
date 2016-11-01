function main(vaargins)

videoFilePath = 'input.mp4';
[frameSequence ,numFrames, frameHeight, frameWidth] = openVideo(videoFilePath);

[inputRect,center] = takeUserInput(frameSequence)

% now we have our target model 
% we need to create a weighted histogram out of our target model
windowSize = inputRect(3);
disp(windowSize);
q = computeWeightedHistogram(frameSequence(1).cdata , center , windowSize);
disp(q);

prevCenter = center;
% now we will run mean shift algo on next frame onwards and find the object
% in next frame
for frameNum = 2 : numFrames
    disp ('Frame Number ---');
    disp(frameNum);
    [currentFrameCenter] = runMeanShiftAlgo( frameSequence(frameNum).cdata , prevCenter, windowSize, q ); 
    frameSequence(frameNum).cdata = drawRectangle(frameSequence(frameNum).cdata , currentFrameCenter , windowSize);
    prevCenter = currentFrameCenter;
    disp(prevCenter);
end

disp(currentFrameCenter);

rectangle('Position' , inputRect , 'EdgeColor' , 'r');
% outputVideo = VideoWriter('output1.mp4');
% open(outputVideo);
% writeVideo(outputVideo , frameSequence);
% close(outputVideo);
movie(frameSequence);


function [inputRect , center  ] = takeUserInput(frameSequence)
%lets show the first frame to user so that he can select the target model
imshow(frameSequence(1).cdata);
hold on;
inputRect = getrect;

%make size even
if rem(inputRect(3) , 2) == 1
    inputRect(3) = inputRect(3) + 1;
end

if rem(inputRect(4) , 2) == 1
    inputRect(4) = inputRect(4) + 1;
end

% for now lets convert the user input to square area
if inputRect(3) > inputRect(4)
    inputRect(3) = inputRect(4);
else
    inputRect(4) = inputRect(3);
end

centerX = inputRect(1) + inputRect(3)/2;
centerY = inputRect(2) + inputRect(4)/2;


center = [centerY  centerX];



