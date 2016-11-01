
function [frameSequence , numFrames,height,width]=openVideo(path)
videoFileHandle = VideoReader(path);
numFrames = videoFileHandle.NumberOfFrames;
height = videoFileHandle.Height;
width = videoFileHandle.Width;
frameSequence(1:numFrames) = struct('cdata', zeros(height, width, 3, 'uint8'), 'colormap', []);
% Read one frame at a time.
for k = 1 : numFrames
    frameSequence(k).cdata = read(videoFileHandle, k);
end