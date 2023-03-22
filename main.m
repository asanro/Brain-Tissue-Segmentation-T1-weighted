% Code execution example
clear all 
images = load("Images\images.mat");
input_image=images.AX(:,:,3);

output_segmentations = MySegmentationFunction(input_image); 

figure
subplot(1,6,1)
imshow(input_image,[])
title('Input image')
subplot(1,6,2)
imshow(output_segmentations(:,:,1),[])
title('Background')
subplot(1,6,3)
imshow(imbinarize(output_segmentations(:,:,2)),[])
title('Skull')
subplot(1,6,4)
imshow(imbinarize(output_segmentations(:,:,3)),[])
title('CSF')
subplot(1,6,5)
imshow(imbinarize(output_segmentations(:,:,4)),[])
title('WM')
subplot(1,6,6)
imshow(imbinarize(output_segmentations(:,:,5)),[])
title('GM')