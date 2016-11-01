% size is the size of kernel window
% radius is the radius of profile
function [kernel] = createKernel(size , radius)

kernel = zeros( ceil(size) , ceil(size) );
for row = 1:size
    for col = 1:size
        % we will create uniform profile ie all 1 if distance from center
        % is less than radius
        % center of kernel will be size/2 , size/2
        distance = (row - size / 2) ^ 2 + (col - size/2)^2;
        if distance < radius ^ 2
            kernel(row , col) = 1;
        end
    end
end