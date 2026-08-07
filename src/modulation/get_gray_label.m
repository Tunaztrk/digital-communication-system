function [label] = get_gray_label(m)
%GET_GRAY_LABEL Generates a binary Gray-code labeling matrix.
%
% Inputs:
%   m                  - Number of bits per codeword.
%
% Outputs:
%   label              - Gray-code labeling matrix.
%
%GET_GRAY_LABEL This function generates a binary Gray code of length m.
%
% Input:
%   m: length of the binary codeword
%
% Output
%   label: a matrix of size Mxm containing all M codewords of a binary Gray
%   code such that two consecutive rows differ in exactly one position

%% of Tuna Öztürk and Kerem Kaya

M = 2^m; % number of symbols
n = 0:M-1; % number of bits per symbol
g = bitxor(n, floor(n/2));
label = zeros(M, m, 'uint8');

for i = 1:M
    for k = 1:m
        label(i, k) = bitget(g(i), m-k+1);
    end
end

end

