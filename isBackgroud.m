%given a diff image find out if window is a part of backgroud
function isBackground = isBackgroud(image , threshold)

isBackground = 1;
image = im2bw(image);

[w , h , ~] = size(image);
maxVal = w * h;

totalSum =  sum(image(:));
percent = totalSum / maxVal;
disp(percent);
if percent > threshold 
    isBackground = 0;
end