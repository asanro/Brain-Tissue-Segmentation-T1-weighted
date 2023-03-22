function [output] = crop_im(image)
% Auxiliar function to perform cropping to the input 'image'
% It iterates over the rows and columns of the 'image' to find
% the cropping coordinates in the background of the image to 
% ensure that useful image information is not cropped.

% image : input image 
% output : output cropped image

image(isnan(image))=0;
crop=struct('row',zeros(2,1),'column',zeros(2,1));

% Rows
for x=1:size(image,1)
    sum_row=sum(image(x,:));
    if sum_row > 0.05
        crop.row(1)=x;
    end
end
for x=size(image,1):-1:1
    sum_row=sum(image(x,:));
    if sum_row > 0.05                  
        crop.row(2)=x;
    end
end
% Columns
for y=1:size(image,2)
    sum_row=sum(image(:,y));
    if sum_row > 0.05
        crop.column(1)=y;
    end
end
for y=size(image,2):-1:1
    sum_row=sum(image(:,y));
    if sum_row > 0.05
        crop.column(2)=y;
    end
end

image_zeropad=image(crop.row(2):crop.row(1),crop.column(2):crop.column(1));
output=image_zeropad;

end