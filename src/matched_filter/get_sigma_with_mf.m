function [sigma] = get_sigma_with_mf(snr_type, snr_dB, M, X, coderate, mf_pulse)
%GET_SIGMA_WITH_MF Computes the AWGN standard deviation accounting for matched-filter energy.
%
% Inputs:
%   snr_type           - SNR definition identifier.
%   snr_dB             - Requested SNR in dB.
%   M                  - Constellation order.
%   X                  - Constellation symbols.
%   coderate           - Channel-code rate.
%   mf_pulse           - Matched-filter impulse response.
%
% Outputs:
%   sigma              - Noise standard deviation.
%
%% GET_SIGMA_WITH_MF

%% of Tuna Öztürk and Kerem Kaya

N0 = channel.get_N0(snr_type, snr_dB, M, X, coderate); %get N0 according to SNR definition

pulse_en = sum(abs(mf_pulse).^2); % energy of mf
sigma = sqrt(N0 / (2 * pulse_en)); % sigma is the noise standard deviation - N0/2 

end

