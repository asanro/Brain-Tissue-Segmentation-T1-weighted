function [output] = classification(image,image_fuzzy,brain,class)
% Performs the classification of the different classes (i.e. tissues)
% of the input 'image' depending on the average intensities

% image : input image 
% image_fuzzy : image output of the fuzzy function
% brain : mask containing the brain
% class : number of classes
% output : output classified image

pos=0;
average_intensity=zeros(2,class);
% Loop over the different classes, to obtain the three brain tissues 
for i=1/class:1/class:1         
        pos=pos+1;
        % Find the indexes in the fuzzy images with respect to the number
        % of classes
        index_image=image_fuzzy==i; 
        % Find the tissue with respect to its index and brain mask
        tissue=double(index_image).*double(image).*brain;
        % Calculates the normalized average intensity of the respective
        % tissue
        average_intensity(:,pos)=[sum(tissue(:))/sum(index_image(:)),i];
end

average_intensity=average_intensity';
average_intensity= sortrows(average_intensity);
% Create an struct with the different tissues
output.whitematter=(image_fuzzy==average_intensity(3,2));
output.graymatter=(image_fuzzy==average_intensity(2,2));
output.csf=(image_fuzzy==average_intensity(1,2));
end
