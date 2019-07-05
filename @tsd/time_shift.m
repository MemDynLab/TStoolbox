function tsd_shifted = time_shift(tsd_orig, shift)
% tsd_shifted = time_shift(tsd_orig, shift) time shifts a tsd 
%
% INPUTS 
% tsd_orig: the tsd to shift
% shift: the time offset for the shift
% 
% OUTPUTS
% tsd_shifted: the shifted tsd

% v1.0 Francesco Battaglia 2019

t = Range(tsd_orig);
d = Data(tsd_orig);

tsd_shifted = tsd(t + shift, d);

