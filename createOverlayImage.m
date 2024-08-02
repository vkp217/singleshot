function I11 = createOverlayImage(background, frontIm, mask)
%%% background - a matrix need to be provided 
%%%

    addpath('D:\MATLAB\Matlab files _ Vi\OverlayDesign')
    frontIm(isnan(frontIm))=0;
    intensity_uint1 = mat2gray(background); % grey image is created
    intensity_uint = im2uint8(intensity_uint1); % grey uint is created
    I11=repmat(intensity_uint,[1,1,3]);
    m2 = logical(mask);
    cmask=repmat(m2,[1,1,3]);
    % figure;imagesc(frontIm)

    % mapi1 = mat2im(frontIm,jet);
    % masp11 = im2uint8(mapi1); % color uint is created
    masp11 = im2uint8(frontIm);
    I11(cmask) = masp11(cmask);
end
