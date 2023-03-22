function output = LP_fourier(image)
% Applies a low pass filter to the input 'image' using
% the Fourier Transform. Creates a circular mask to remove 
% high frequency components in the images. 
% This is used for noise reduction

% image : input image 
% output : output filtered image

% calculate the mask radius
radius = min(size(image))/2;
FT_image =  fftshift(fft2(image)); 

% Create the low frequencies removal mask. 
size_images=size(image);  % All images have the same size. 
[xGrid,yGrid] = meshgrid(1:size_images(2),1:size_images(1));
mask_fourier = sqrt((xGrid - size_images(2)/2).^2 + (yGrid - size_images(1)/2).^2) <= radius;

% Filter the images.
FT_image=FT_image.*mask_fourier;

% Inverse fourier transform.
inv_fft = real(ifft2(ifftshift(FT_image))); %fourier_transform.SAG(:,:,i)

% Background
output=im2double(inv_fft+abs(min(inv_fft(:)))); % All values are positive 
output = output./max(output(:));

end