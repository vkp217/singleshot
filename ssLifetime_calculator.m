function [rratio, output] = ssLifetime_calculator(tpsfs1, tpsfs2, gate_width, gate_num, ratio, tau, step)
ratio1 = tpsfs1./tpsfs2;
% gate_width = 3; %gate width in Nanoseconds
% gate_num = 37;
T = 12.5; %  laser repetition rate in ns
gate_delay = T/135;
gate_std = 41;
rratio = squeeze(ratio1(:,:,gate_num));
figure; subplot(1,2,1); imagesc(rratio); colorbar
title('rratio')
[a1,a2] = size(rratio);
rratio_vec = rratio(:);
k = ((gate_width-1)/step)+1;
vq_vec = interp1(squeeze(ratio(k,:)), tau, rratio_vec, 'nearest');
vq = reshape(vq_vec, a1, a2) - 0.5 - ((gate_std-gate_num)*gate_delay);
% vq = reshape(vq_vec, a1, a2) - (200*10^-3);
output = vq;
output(isnan(output))=0;
subplot(1,2,2); imagesc(vq);colorbar
title('computed lifetime')
set(gcf,'Position', [100 100 1400 550])
end
