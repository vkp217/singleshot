function [RGB] = mat2imWithScale(A,color_map, high_lim)
%MAT2IMWITHSCALE Summary of this function goes here
%%%% written by Vikas Pandey, July 2024
% figure; imagesc(A); colormap('jet')
cmap1 = colormap(color_map);
numColors = size(cmap1, 1);
minVal = min(A(:));
maxVal = max(A(:));

mat = A - minVal;
mat = mat./(maxVal - minVal);

a = round(maxVal*numColors/high_lim);

scaledData = round(mat .* (a - 1)) + 1;
scaledData = max(1, min(scaledData, numColors));
RGB = cmap1(scaledData, :);
RGB = reshape(RGB, [size(A, 1), size(A, 2), 3]);
end

