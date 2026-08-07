function pulse = rrc(filterspan, rolloff, n_os, design_type)
%RRC Generates a root-raised-cosine pulse in the time or frequency domain.
%
% Inputs:
%   filterspan         - Filter span in symbols.
%   rolloff            - Root-raised-cosine roll-off factor.
%   n_os               - Oversampling factor.
%   design_type        - Design domain selector: time or freq.
%
% Outputs:
%   pulse              - Root-raised-cosine pulse samples.
%
%RRC This
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
pulse = zeros(1,n_os*filterspan);

if strcmp(design_type, 'time')
    T = 1;
    t = (0:N-1) / n_os;
    t = t - filterspan/2;

    for i = 1:length(t)

        if t(i) == 0
            pulse(i) = (1/sqrt(T)) * (1 - rolloff + 4*rolloff/pi);

        elseif abs(t(i)) == T/(4*rolloff)
            pulse(i) = (rolloff/sqrt(2*T)) * ...
            ((1 + 2/pi) * sin(pi/(4*rolloff)) + ...
            (1 - 2/pi) * cos(pi/(4*rolloff)));

        else
            pulse(i) = (1/sqrt(T)) * ...
            (sin(pi*t(i)/T*(1-rolloff)) + ...
            4*rolloff*t(i)/T*cos(pi*t(i)/T*(1+rolloff))) / ...
            ((pi*t(i)/T) * (1 - (4*rolloff*t(i)/T)^2));
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
                pulse(k) = sqrt(0.5 * ...
                (1 + cos((pi/rolloff) * (nu - (1-rolloff)/2))));
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


