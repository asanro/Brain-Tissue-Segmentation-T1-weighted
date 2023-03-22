function [output] = filt_average(image)
% Performs a default averaging filter on the input 'image'

% image : input image 
% output : output filtered image

% Define an appropriate kernel HSIZE
HSIZE = 3;

% Create an averaging filter H of size HSIZE
element = fspecial('average',HSIZE);

% Filter the noise using the above defined kernel
output = imfilter(image,element); 

end