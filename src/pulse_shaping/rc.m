function pulse = rc(filterspan, rolloff, n_os, design_type)
%RC Generates a raised-cosine pulse in the time or frequency domain.
%
% Inputs:
%   filterspan         - Filter span in symbols.
%   rolloff            - Raised-cosine roll-off factor.
%   n_os               - Oversampling factor.
%   design_type        - Design domain selector: time or freq.
%
% Outputs:
%   pulse              - Raised-cosine pulse samples.
%
%RC This
%   Inputs:
%   filterspan: Filterspan in number of symbols
%   rolloff: roll-off factor for the trade-off mentioned in the script
%   n_os: oversampling factor
%   design_type: freq or time

%% of Tuna Öztürk and Kerem Kaya

assert(mod(filterspan,2)==0,'filterspan must be an even number');
assert(filterspan >= 2, 'filterspan must be at least 2');
assert(rolloff >= 0 && rolloff <= 1, 'rolloff must be between 0 and 1');

N = filterspan * n_os;
pulse = zeros(1,filterspan*n_os);

if strcmp(design_type, 'time')
    T = 1;
    t = (0:N-1) / n_os;
    t = t - filterspan/2;

    for i = 1:length(t)

        if rolloff == 0
            pulse(i) = sinc(t(i)/T);

        elseif t(i) == 0
            pulse(i) = 1;

        elseif abs(t(i)) == T/(2*rolloff)
            pulse(i) = (pi/4) * sinc(1/(2*rolloff));

        else
            pulse(i) = sinc(t(i)/T) * cos(pi*rolloff*t(i)/T) ...
            / (1 - (2*rolloff*t(i)/T)^2);

        end

    end

elseif strcmp(design_type, 'freq')

    u = 0:N-1;
    u_shift = u - floor(N/2);

    for k = 1:N
        nu = abs(n_os * u_shift(k) / N);

        if nu <= (1-rolloff)/2
            pulse(k) = 1;

        elseif nu <= (1+rolloff)/2

            if rolloff == 0
                pulse(k) = 0;

            else
                pulse(k) = 0.5 * ...
                (1 + cos((pi/rolloff) * (nu - (1-rolloff)/2)));

            end

        else

            pulse(k) = 0;

        end

    end

    pulse = real(fftshift(ifft(ifftshift(pulse)))) * n_os;

else

    error('design_type must be ''time'' or ''freq''');

end


end

