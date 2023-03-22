function [output] = fuzzy(image,levels)
% Performs fuzzy c-means clustering on the given 'image'
% and returns 'levels' cluster centers.


% image : input image 
% levels : number of clusters
% output : output classified image

value=0;
% Create data array
data = [image(:)]; 
% Find 'levels' (i.e. 3) clusters using fuzzy c-means clustering.
% center : are the final cluster centers
% U : fuzzy partition matrix
% obj_fcn : objective function values
[center,U,obj_fcn] = fcm(data,levels); 
% create empty matrix to input the classification values
fcmImage(1:length(image))=0;   
maxU = max(U);
for i=1:levels

    clear index


    % Finding the pixels for each class
    % Classify them into the cluster with the largest membership value.
    index = find(U(i,:) == maxU);

    % Assigning pixel to each class by giving them a specific value
    value=1/levels +value;
    fcmImage(index)= value;

end

output = reshape(fcmImage,size(image));

end