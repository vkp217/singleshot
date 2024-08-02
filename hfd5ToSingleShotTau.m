function [tpsfs1, tpsfs2, rratio, SStau] = hfd5ToSingleShotTau(fname,tau_range_lut, tau_step_lut, gate_width, gate_num)
%HFD5TOSINGLESHOTTAU Summary of this function goes here
%%%%%%% written by Vikas Pandey,Ph.D.July 2024

% fname = 'E:\Vikas\04262024datacollection\af700all\af700 - Copy (43)\Af700_740bp49_0242.hdf5';
t0 = 0;
% step = 0.1;
% tau_range = [300, 3000];
% gate_width = 3;
% gate_num = 41;
[tau, ratio] = ssLUT(t0, tau_step_lut, tau_range_lut); % making the LUT
[tpsfs1, ~, tpsfs2, ~] = ss3readHDF5File2(fname);
[rratio, SStau] = ssLifetime_calculator(tpsfs1,tpsfs2,gate_width, gate_num, ratio, tau, tau_step_lut);
end

