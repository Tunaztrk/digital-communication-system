function [N0] = get_N0(snr_type, snr_dB, M, X, coderate)
%GET_N0 Computes the noise parameter N0 from the selected SNR definition.
%
% Inputs:
%   snr_type           - SNR definition identifier.
%   snr_dB             - Requested SNR in dB.
%   M                  - Constellation order.
%   X                  - Constellation symbols.
%   coderate           - Channel-code rate.
%
% Outputs:
%   N0                 - Noise power spectral density parameter.
%

%% of Tuna Öztürk and Kerem Kaya

N0 = 0;
Es = mean(abs(X).^2);
m = log2(M);
snr_lin = 10^(snr_dB/10);

if strcmpi(snr_type, 'esn0')

    N0 = Es / snr_lin;

elseif strcmpi(snr_type, 'ebn0')

    N0 = Es / (snr_lin * m * coderate);

elseif strcmpi(snr_type, 'snr')

    if isreal(X)

        N0 = 2 * Es / snr_lin;

    else

        N0 = Es / snr_lin;

    end
    
end




