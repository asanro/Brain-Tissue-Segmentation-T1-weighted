function output_segmentations = MySegmentationFunction(input_image) 
%% Preprocessing
image_averaged=filt_average(input_image);
corrected_image = RunN4ANTS(image_averaged);
image_lp = LP_fourier(corrected_image);

%% Background
image_thresholding = otsu(image_lp);

R = 60;                                              
image_background = imclose(image_thresholding,strel('disk', R));

%% Brain mask
N = 2;
R = round((N*size(input_image,1)*size(input_image,2))/(240*240));

image_eroded= imerode(image_thresholding,strel('disk', R));

% Connected component analysis
% Compute the number of voxels for each label
[L,N] = bwlabeln(image_eroded,4);
NofVoxels = zeros(N,1);
for ij=1:N
   NofVoxels(ij) = length(find(L==ij));
end
[~,max_component] = max(NofVoxels);
BrainSegmentation = L == max_component;

BrainSegmentation= imdilate(BrainSegmentation,strel('disk', R));
brain=opt_closing(BrainSegmentation);

%% Brain tissue: white, gray matter and csf
% Three classes
class=3; 
image_fuzzy=fuzzy(brain.*corrected_image,class);

%% Tissue Classification 
final_image=classification(corrected_image,image_fuzzy,brain,class);
brain_dilated = imdilate(brain,strel('disk', 1));
final_image.csf=final_image.csf.*brain_dilated;
final_image.skull=image_background.*input_image.*abs(1-brain);

% Create final struct
output_segmentations = double(imcomplement(image_background));
output_segmentations(:,:,2) = final_image.skull;
output_segmentations(:,:,3) = final_image.csf.*input_image;
output_segmentations(:,:,4)= final_image.whitematter.*input_image;
output_segmentations(:,:,5) = final_image.graymatter.*input_image;

end