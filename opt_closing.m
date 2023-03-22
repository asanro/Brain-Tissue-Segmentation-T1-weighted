function [closed_image] = opt_closing(image)
% Performs an optimal closing morphological operation on a mask
% It loops over a closing radius 'r' until the image is closed


% image : input image 
% output : binary output closed image

% Turn images into binary 
image(image>0)=1;
image(image<0)=0;

% Find optimal value of the radius to perform the morphological operation
for r=1:100
    completed=1;
    N=2;
    while (N>1&&completed==1)
        se = strel('disk',r);
        mask_background_close=imclose(image,se);
        % Perform connected component analysis
        [closed_image,N] = bwlabeln(mask_background_close,8);
        completed=0;
        % Ensures that the mask is continous
        for x=1:size(closed_image,1)-1 
            % Number of spaces on each row
            NofSpaces=0;                 
            for y=1:size(closed_image,2)-1
                if closed_image(x,y)~=closed_image(x,y+1)
                    NofSpaces=NofSpaces+1;
                end
                % If there is a gap in the image, continue iterating
                if NofSpaces>2          
                    completed=1;
                end
            end
        end
    end
end

end