function [w] = get_zf(system_impulse_response,K)
%GET_ZF Computes a zero-forcing equalizer for the discrete-time channel model.
%
% Inputs:
%   system_impulse_response - Discrete-time system impulse response.
%   K                  - Equalizer half-length parameter.
%
% Outputs:
%   w                  - Zero-forcing equalizer coefficients.
%
%% GET_ZF Summary 
% the function constructs the required parameters for zero forcing, such as
% H matrix of Toeplitz structure, input and output sequence etc.
%
%% Detailed explanation goes here
% First, the Toeplitz channel matrix H is built from the sampled system
% impulse response. Then, the zero-forcing filter coefficients are computed
% according to the pseudoinverse formula. All formulas are according to the
% script

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

w = (H*H') \ (H*e);
w = w(:)';
end