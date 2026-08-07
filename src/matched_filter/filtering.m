function [y_os,t] = filtering(r, mf_pulse, n_os, symbol_rate)
%FILTERING Filters a received waveform with the matched-filter pulse.
%
% Inputs:
%   r                  - Received signal.
%   mf_pulse           - Matched-filter impulse response.
%   n_os               - Oversampling factor.
%   symbol_rate        - Symbol rate.
%
% Outputs:
%   y_os               - Oversampled matched-filter output.
%   t                  - Time vector for the filtered signal.
%
%% FILTERING 
%  this function outputs the y_os from filtering the received signal r.
%  This signal will later be used with the oversampling values for the
%  re-time-discretization of the signal.
%  So basically, we are at the DAC (Digital-Analog-Conversion) part.

%% Detailed explanation 
%  the function of y_os is given in the formula 4.10 in script.
%  we then calculate dt and t values for later use in sampling from the
%  over-sampled data.

%% of Tuna Öztürk and Kerem Kaya

    y_os = zeros(1,length(mf_pulse)+length(r)-1);
    t = zeros(size(y_os));
    
    y_os = conv(r, mf_pulse); % formula 4.10
    dt = 1 / (symbol_rate * n_os); % distance between oversamples, formula derives from T/ n_os.
    t = (0:length(y_os)-1) * dt;

end

