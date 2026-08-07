function r = lp_filter(r_tilde_IQ, lp_impulse_response)
%LP_FILTER Applies lowpass filtering to a demodulated baseband signal by convolution.
%
% Inputs:
%   r_tilde_IQ         - Demodulated baseband signal.
%   lp_impulse_response - Lowpass-filter impulse response.
%
% Outputs:
%   r                  - Lowpass-filtered output signal.
%

%% RECT Summary
% the function is the last module in the Figure 5.3
%
%
%% Detailed explanation
% the function completes the step for acquiring R(t) as we 
% apply convolution in the time domain. The inputs for the function
% are to be obtained outputs of the previous tasks already.
%
%% of Tuna Öztürk and Kerem Kaya
    
r = conv(r_tilde_IQ, lp_impulse_response);

end

