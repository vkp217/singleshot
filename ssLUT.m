function [tau, ratio] = ssLUT(t0, step, tau_range)
%SSLUT Summary of this function goes here

% t0 = 0;
% step = 0.1; % the min increment in LUT

w = 1:step:10;
T = 12.5;
% tau_range = [300, 3000];
tau = (tau_range(1):tau_range(2)).*10^-3;
ratio = zeros(length(w), length(tau));
for i=1:length(w)
    cal1 = exp(-t0./tau);
    cal2 = exp(-(t0+w(i))./tau);
    cal3 = 1-exp(-T./tau);
    cal4 = cal1 - cal2;
    ratio(i,:) = cal4./cal3;
end
end

