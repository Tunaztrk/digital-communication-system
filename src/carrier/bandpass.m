function impulse_response = bandpass(f_c, filterspan, B, n_os)
%BANDPASS Creates the oversampled impulse response of an ideal bandpass filter.
%
% Inputs:
%   f_c                - Carrier/center frequency.
%   filterspan         - Filter span in symbols.
%   B                  - Bandpass bandwidth.
%   n_os               - Oversampling factor.
%
% Outputs:
%   impulse_response   - Time-domain bandpass-filter impulse response.
%
%% BANDPASS Summary 
% This function creates the oversampled impulse response of an ideal
% bandpass filter. The filter is designed once again with frequency
% domain approach and then transformed into the time domain by using 
% the IFFT. again.
%
%% Detailed explanation 
% First, a frequency response H is defined. It is equal to 1 in the two
% passbands around +f_c and -f_c, each with bandwidth B, and 0 elsewhere.
% This corresponds to the ideal bandpass characteristic shown in the task.
% Then, the impulse response is obtained by applying the ifft to H. 
% The result is returned as a row vector.
%
%% of Tuna Öztürk and Kerem Kaya

assert(mod(filterspan,2)==0,'filterspan must be an even number');

N = filterspan * n_os;
H = zeros(1,N);

u = 0:N-1;
u_shift = u - floor(N/2);

for i = 1:N
    f = n_os * u_shift(i) / N;
    if abs(f - f_c) <= B/2 || abs(f + f_c) <= B/2
        H(i) = 1;
    else
        H(i) = 0;
    end

end

impulse_response = real(fftshift(ifft(ifftshift(H))));

end