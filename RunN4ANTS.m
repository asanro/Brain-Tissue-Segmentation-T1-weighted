function Debiased = RunN4ANTS(filein)
    ANTS_LOCATION = fullfile(pwd,'N4');%'/Applications/Work/ANTs/bin/';
    addpath(ANTS_LOCATION);
    isfake = 0;
    if(~ischar(filein))
       fake_img = make_nii(filein);
       save_nii(fake_img,'fakefile.nii');
       filein = 'fakefile.nii';
       isfake = 1;
    end
    if(ispc)
        cmd = ['N4BiasFieldCorrection -d 2 -i ' filein ' -o temp.nii -c [10x10x10x100,0] -v'];
    elseif(ismac)
        cmd = ['N4BiasFieldCorrection_mac -d 2 -i ' filein ' -o temp.nii -c [10x10x10x100,0] -v'];
    elseif(isunix)
        cmd = ['N4BiasFieldCorrection_lnx -d 2 -i ' filein ' -o temp.nii -c [10x10x10x100,0] -v'];
    else
        error('Unsupported OS');
    end
    system(fullfile(ANTS_LOCATION,cmd));
    file = load_untouch_nii('temp.nii');
    % imwrite(file.img,fileout);
    Debiased = file.img;
    delete('temp.nii');    
    if(isfake == 1)
        delete(filein);
    end
end