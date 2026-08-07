function [y,t] = sampling(y_os,t_os,n_os,filterspan_pulse,filterspan_mf)
%SAMPLING Samples the matched-filter output at symbol-rate sampling instants.
%
% Inputs:
%   y_os               - Oversampled filtered signal.
%   t_os               - Oversampled time vector.
%   n_os               - Oversampling factor.
%   filterspan_pulse   - Transmit-filter span.
%   filterspan_mf      - Matched-filter span.
%
% Outputs:
%   y                  - Sampled symbol sequence.
%   t                  - Sampling-time vector.
%
%% SAMPLING 
%  we sample the y_os to obtain a time-discrete signal once again.

%% Detailed Explanation 
%  we assign the  values of oversampling into the row vector y with an iterative
%  approach, as we also denote the corresponding time values into another
%  row vector called t, which is simply the time vector.

%% of Tuna Öztürk and Kerem Kaya

start_idx = (filterspan_pulse + filterspan_mf - 1) * n_os; % first sampling point assigned
sample_idx = start_idx:n_os:length(y_os);

y = zeros(1,length(sample_idx));
t = zeros(size(y));

for i = 1:length(y)

    idx = start_idx + (i-1) * n_os;
    y(i) = y_os(idx);
    t(i) = t_os(idx);

end

end
