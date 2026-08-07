function [r_tilde_IQ] = demodulate(seq_in,f,phase,n_os,is_complex)
%DEMODULATE Demodulates a received passband signal to its baseband I/Q representation.
%
% Inputs:
%   seq_in             - Received passband signal.
%   f                  - Demodulation carrier frequency.
%   phase              - Carrier phase offset.
%   n_os               - Oversampling factor.
%   is_complex         - Flag selecting complex I/Q or real in-phase output.
%
% Outputs:
%   r_tilde_IQ         - Demodulated baseband signal.
%
%% DEMODULATE Summary
% the function converts the received, yet probably distorted noisy bandpass
% signal back to the signal R(t); which supposed to be ideally exact same 
% with the sent S(t) signal. 
%
%% Detailed Explanation
% The function calculates with the given the received function R~i,q(t) =
% r~_I + jr~_Q, according to the functions given in the script. Lowpass is 
% not applied currently
%
%% of Tuna Öztürk and Kerem Kaya


t = (0:length(seq_in)-1) / n_os;

r_I = seq_in .* (sqrt(2) * cos(2*pi*f*t + phase));
r_Q = seq_in .* (-sqrt(2) * sin(2*pi*f*t + phase));

if is_complex
    r_tilde_IQ = r_I + 1j * r_Q;
else
    r_tilde_IQ = r_I;
end

end

