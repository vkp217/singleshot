load mock_surgery_UnetPred.mat % load data for DL model generated tau
load final_data.mat % load data for intensity and calculated tauj
save_folder = 'E:\Vikas\single-shot\combinedTiff3'; % final folder where all the tiff images to be saved
cd(save_folder)
for i=1:size(preds2,1)
    figure;
    
    % subplot (132)
    ax2 =subplot ('Position',[0.355 0.05 0.3 0.85]);
    p2 = squeeze(final_data(i,:,:,3));
    bg2 = zeros(size(p2));
    mask2 = ones(size(p2));
    mask2((p2<0.2)) = 0;
    high_lim = 2; % setting the scale to 2
    [RGB2] = mat2imWithScale(p2, jet, high_lim);
    pI2 = createOverlayImage(bg2, RGB2, mask2);
    imagesc(pI2)
    set(gca, 'xtick',[]); set(gca, 'ytick', [])
    colormap (ax2,'jet')
    clim([0,2]); colorbar
    title('ComputedLifetime')

    % subplot (133)
    ax3 =subplot ('Position',[0.68 0.05 0.3 0.85]);
    p3 = squeeze(preds2(i,:,:));
    bg3 = zeros(size(p3));
    mask3 = ones(size(p3));
    mask3(p3<0.2) = 0;
    high_lim = 2; % setting the scale to 2
    [RGB3] = mat2imWithScale(p3, jet, high_lim);
    pI3 = createOverlayImage(bg3, RGB3, mask3);
    imagesc(pI3)
    set(gca, 'xtick',[]); set(gca, 'ytick', [])
    colormap (ax3,'jet')
    clim([0,2]); colorbar
    title('DL-Lifetime')

    % subplot (131)
    ax1 = subplot ('Position',[0.03 0.05 0.3 0.85]);
    imagesc(squeeze(final_data(i,:,:,2)))
    set(gca, 'xtick',[]); set(gca, 'ytick', [])
    colormap (ax1, 'gray')
    clim([0,10]);
    title('Intensity')
    
    set(gcf,'Position', [100 100 1800 550])


    temp = getframe(gcf);
    filename = fullfile(save_folder, ['seq',num2str(i),'.tif']);
    imwrite(temp.cdata,filename)
    clear temp
    close 
end