function [discrete_pulse,sigma2_rx] = get_discrete_channel_model(n_os,tx_pulse,rx_pulse,channel_pulse,filterspan_pulse,sigma2_ch)
%GET_DISCRETE_CHANNEL_MODEL Constructs the sampled discrete-time channel model and receive-noise variance.
%
% Inputs:
%   n_os               - Oversampling factor.
%   tx_pulse           - Transmit pulse.
%   rx_pulse           - Receive-filter pulse.
%   channel_pulse      - Channel impulse response.
%   filterspan_pulse   - Pulse-shaping filter span.
%   sigma2_ch          - Channel-noise variance.
%
% Outputs:
%   discrete_pulse     - Sampled discrete-time system impulse response.
%   sigma2_rx          - Noise variance after receive filtering.
%
%% GET_DISCRETE_CHANNEL_MODEL Summary 
% code calculates the discrete time model stated in the script
%
%% Detailed explanation 
% First, the overall oversampled system pulse is obtained by convolving the
% transmit pulse (g), channel pulse (h_lp) and receive pulse (h_r).Then, the correct
% sampling points are determined and we oversample. Finally, the filtered noise variance
% is calculated from the receive filter energy.
%
%% of Tuna Öztürk and Kerem Kaya

overall_pulse = conv(tx_pulse, channel_pulse);
overall_pulse = conv(overall_pulse, rx_pulse);

first_sample = (2 * filterspan_pulse - 1) * n_os;
number_of_samples = floor((length(overall_pulse) - first_sample) / n_os) + 1;
discrete_pulse = zeros(1, number_of_samples);

for i = 1:number_of_samples

    current_index = first_sample + (i-1) * n_os;
    discrete_pulse(i) = overall_pulse(current_index);

end

if mod(length(discrete_pulse), 2) == 0
    discrete_pulse = [discrete_pulse 0];

end

rx_energy = sum(abs(rx_pulse).^2);
sigma2_rx = sigma2_ch * rx_energy;

end

