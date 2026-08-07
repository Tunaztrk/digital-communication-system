function [X,label] = get_ask(M)
%GET_ASK Generates an M-ASK constellation and its binary labeling.
%
% Inputs:
%   M                  - Constellation order.
%
% Outputs:
%   X                  - ASK constellation symbols.
%   label              - Binary labeling matrix.
%
% GET_ASK Initialization of M-Amplitude-Shift-Keying (M-ASK) constellation.
% Outputs the points and the labels of an M-ASK constellation with unit
% average power.
%
% Inputs:
%   M:  Number of symbols in the ASK constellation
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the ASK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the M ASK
%           symbols where m=log2(M)

%% of Tuna Öztürk and Kerem Kaya

%% for the code to function, M must be an integer power of 2

m = log2(M);
X = -(M-1):2:(M-1);
X = X / sqrt(mean(abs(X).^2)); %normalization

label = modulation.get_gray_label(m);

end

