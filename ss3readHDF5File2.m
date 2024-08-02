function [tpsfs1, inten1, tpsfs2, inten2] = ss3readHDF5File2(fname)
    %%%%%%% By Vikas Pandey, 18th April 2024 %%%%%%%
    % fname = 'AF700_740bp_0001.hdf5';
    % tpsfs1 is Bottom G2 gate (TPSFS)
    % tpsfs2 is Bottom INT gate (Intensity Image)
    % Write the file name in "fname" you want to open
    inf = h5info(fname);
    level2 = inf.Groups(2);
    a = level2.Datasets;
    [l, ~] = size(a);
    
    bottomG2_num = zeros(l, 1);
    bottomInt_num = zeros(l, 1);
    
    for ii = 1:l
        if strcmp(a(ii).Name(1:14), 'Bottom G2 Gate')
            bottomG2_num(ii) = str2double(a(ii).Name(16:end));
        elseif strcmp(a(ii).Name(1:15), 'Bottom INT Gate')
            bottomInt_num(ii) = str2double(a(ii).Name(17:end));
        end
    end
    
    bottomG2_num = sort(nonzeros(bottomG2_num));
    bottomInt_num = sort(nonzeros(bottomInt_num));
    
    p = a(1).Dataspace.Size;
    x = p(1);
    y = p(2);
    
    tpsfs1 = zeros(x, y, length(bottomG2_num));
    tpsfs2 = zeros(x, y, length(bottomInt_num));
    
    for i = 1:length(bottomG2_num)
        gateN1 = ['Bottom G2 Gate ', num2str(i)];
        fr1 = ['/Gate Images/', gateN1];
        data1 = h5read(fname, fr1);
        tpsfs1(:,:,i) = double(data1);
    end
    
    for j = 1:length(bottomInt_num)
        gateN2 = ['Bottom INT Gate ', num2str(j)];
        fr2 = ['/Gate Images/', gateN2];
        data2 = h5read(fname, fr2);
        tpsfs2(:,:,j) = double(data2);
    end
    
    inten1 = sum(tpsfs1, 3);
    inten2 = sum(tpsfs2, 3);
    
    % figure;
    % imagesc(inten1);
    % title('bottom G2');
    % 
    % figure;
    % imagesc(inten2);
    % title('bottom INT');
end

