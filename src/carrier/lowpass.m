function impulse_response = lowpass(filterspan, B, n_os)
%LOWPASS Creates the oversampled impulse response of an ideal lowpass filter.
%
% Inputs:
%   filterspan         - Filter span in symbols.
%   B                  - Lowpass bandwidth.
%   n_os               - Oversampling factor.
%
% Outputs:
%   impulse_response   - Time-domain lowpass-filter impulse response.
%
%% SINC Summary 
% the function designs a lowpass filter with its spectral design to
% implement on the demodulation and obtain the a signal, whose components
% in 2f_0 frequency are got rid off.
%
%
%% Detailed explanation 
% first we define the frequency window of the low-pass filter, then convert
% it to a filter vector in time domain with the inverse fourier transformation
% function (ifft)
%
%% of Tuna Öztürk and Kerem Kaya

assert(mod(filterspan,2)==0,'filterspan must be an even number');

N = filterspan * n_os;
H = zeros(1,N);
u = 0:N-1;

u_shift = u - floor(N/2);

for i = 1:N
    f = n_os * u_shift(i) / N;

    if abs(f) <= B/2
        H(i) = 1;
    else
        H(i) = 0;
    end
end

impulse_response = real(fftshift(ifft(ifftshift(H))));

end