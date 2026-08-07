function [s_tilde] = modulate(s,f_0,n_os)
%MODULATE Performs carrier modulation of a complex baseband signal.
%
% Inputs:
%   s                  - Complex baseband signal.
%   f_0                - Carrier frequency.
%   n_os               - Oversampling factor.
%
% Outputs:
%   s_tilde            - Real-valued passband signal.
%
%% MODULATE Summary
% the function calculates the bandpass signal centered on the carrier
% frequency f_0 for the carrier modulation.
%
%% Detailed explanation
% we adjust the time vector according to the value of the oversampling. 
% The consequent functions/calculations are all according to the functions given in the
% lecture notes
% 
%% of Tuna Öztürk and Kerem Kaya

t = (0:length(s)-1) / n_os;

s_I = real(s);
s_Q = imag(s);

s_tilde = sqrt(2) * s_I .* cos(2*pi*f_0*t) - sqrt(2) * s_Q .* sin(2*pi*f_0*t);
s_tilde = real(s_tilde);

end