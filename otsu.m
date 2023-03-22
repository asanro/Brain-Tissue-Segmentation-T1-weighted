function [output] = otsu(image)
% Performs a global threshold T from grayscale image 'image'
% using Otsu's method

% image : input image 
% output : binary output thresholded image

T = graythresh(image);  % Background thershold
output=image<=T;        % Remove the values that are 0.
output=~output;
end