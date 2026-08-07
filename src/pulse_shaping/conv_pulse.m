function [s,t] = conv_pulse(x,pulse,n_os,symbol_rate)
%CONV_PULSE Generates a pulse-shaped waveform by upsampling and convolution.
%
% Inputs:
%   x                  - Input symbol sequence.
%   pulse              - Pulse-shaping impulse response.
%   n_os               - Oversampling factor.
%   symbol_rate        - Symbol rate.
%
% Outputs:
%   s                  - Pulse-shaped output waveform.
%   t                  - Output time vector.
%
%CONV_PULSE 

%% of Tuna Öztürk and Kerem Kaya

x = x(:).';
pulse = pulse(:).';
symbol_number = length(x);
pulse_length = length(pulse);

x_os = zeros(1, symbol_number * n_os);
x_os(1:n_os:end) = x;

s_conv = conv(x_os, pulse); % according to equation 4.2
s = s_conv(1:symbol_number * n_os); % for tail cutting

dt = 1 / (symbol_rate * n_os);
t = (0:length(s)-1) * dt;

end

