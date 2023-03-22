function [output] = bias_correction(image)
radius=2;
    FT_image =  fftshift(fft2(image)); 
    
    % Create the low frequencies removal mask. 
    size_images=size(image);  % All images have the same size. 
    [xGrid,yGrid] = meshgrid(1:size_images(2),1:size_images(1));
    mask_fourier = sqrt((xGrid - size_images(2)/2).^2 + (yGrid - size_images(1)/2).^2) <= radius;
    mask_fourier=~mask_fourier;
    
    % Filter the images.
    FT_image=FT_image.*mask_fourier;
    
    % Inverse fourier transform.
    inv_fft = real(ifft2(ifftshift(FT_image))); %fourier_transform.SAG(:,:,i)

    % Background
    images_zeros_background=images.COR(:,:,i);  % Help preserve the zero values of the background. 
    output=inv_fft+abs(min(inv_fft(:))); % All values are positive 
end