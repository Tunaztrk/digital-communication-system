function [mf_pulse] = get_mf(g_pulse)
%GET_MF Constructs a normalized matched filter from the transmit pulse.
%
% Inputs:
%   g_pulse            - Transmit pulse.
%
% Outputs:
%   mf_pulse           - Matched-filter impulse response.
%
%GET_MF 

%% of Tuna Öztürk and Kerem Kaya 

% according to 4.12: h_r(t)= K.g^*(T-t) := Matched Filter
% because of symmetry the function stays the same, through convolution we
% can determine the factor K for value 1 at sampling point.

mf_pulse = zeros(size(g_pulse));
g_pulse = g_pulse(:).';

convolution = conv(g_pulse, g_pulse);
mid_idx = ceil(length(convolution) / 2); %spot the middle spot (peak)

K = 1 / convolution(mid_idx); %now the amplitude of the mf_pulse output would be 1.

mf_pulse = K * g_pulse;

end

