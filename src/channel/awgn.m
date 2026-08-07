function [seq_out] = awgn(seq_in, N0)
%AWGN Adds additive white Gaussian noise to a real or complex input sequence.
%
% Inputs:
%   seq_in             - Input signal sequence.
%   N0                 - Noise power spectral density parameter.
%
% Outputs:
%   seq_out            - Noisy output sequence.
%

%% of Tuna Öztürk and Kerem Kaya

seq_in = seq_in(:).';

if isreal(seq_in)

    noise = sqrt(N0/2) * randn(size(seq_in));

else

    noise = sqrt(N0/2) * randn(size(seq_in)) ...
    + 1i * sqrt(N0/2) * randn(size(seq_in));

end

seq_out = seq_in + noise;

end
