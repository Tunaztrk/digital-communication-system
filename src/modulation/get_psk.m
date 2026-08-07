function [X,label] = get_psk(M)
%GET_PSK Generates an M-PSK constellation and its binary labeling.
%
% Inputs:
%   M                  - Constellation order.
%
% Outputs:
%   X                  - PSK constellation symbols.
%   label              - Binary labeling matrix.
%
%GET_PSK Initialization of M-Phase-Shift-Keying (M-PSK) constellation.
%Outputs the points and the labels of an M-PSK constellation with unit
%average power.
%
% Inputs:
%   M:  Number of symbols in the PSK constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the PSK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M PSK
%           symbols where m=log2(M)

%% of Tuna Öztürk and Kerem Kaya

%% for the code to function, M must be an integer power of 2

m = log2(M);
k = 0:M-1;
X = exp(1i * 2 * pi * k / M);
X = X / sqrt(mean(abs(X).^2));

label = modulation.get_gray_label(m);

end

