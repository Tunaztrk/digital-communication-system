function [w] = get_lmmse(system_impulse_response,K,sigma2)
%GET_LMMSE Computes a linear minimum mean-square error equalizer.
%
% Inputs:
%   system_impulse_response - Discrete-time system impulse response.
%   K                  - Equalizer half-length parameter.
%   sigma2             - Noise variance.
%
% Outputs:
%   w                  - LMMSE equalizer coefficients.
%
%% GET_LMMSE Summary 
% the function constructs the required parameters for lmmse depicted in the 
% script
%
%% Detailed explanation goes here
% first we assign h and set the Length L. Then we set the length of the
% rows and columns respectively. In the following we set the values of the
% H matrix iterative with the for loop. At the end we set the solution
% according to the formula in the script.
%

h = system_impulse_response(:).';
L = (length(h)-1)/2;

rows = 2*K + 1;
cols = 2*(K+L) + 1;

H = zeros(rows, cols);

for i = 1:rows
    H(i, i:i+2*L) = h;
end

e = zeros(cols, 1);
e(K+L+1) = 1;

w = (H*H' + sigma2*eye(rows)) \ (H*e); % (5.60)
w = w(:).';

end

