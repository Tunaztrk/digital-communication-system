function [seq_out] = map_to_diff_constellation(seq_in,X,label)
%MAP_TO_DIFF_CONSTELLATION Maps a binary input sequence to a constellation using differential encoding.
%
% Inputs:
%   seq_in             - Binary input sequence.
%   X                  - Constellation symbols.
%   label              - Binary labeling matrix.
%
% Outputs:
%   seq_out            - Differentially mapped symbol sequence.
%
%MAP_TO_DIFF_CONSTELLATION This function maps a binary input sequence to a
%sequence of symbols from a given constellation using a specified label in
%a differential manner.
%
% Inputs: 
%   seq_in: binary input sequence of length n given as a 1xn vector of type
%           uint8.
%   X:      vector of size 1xM containing the M-symbols of the given
%           constellation.
%   label:  matrix of size Mxm containing the binary labels of the M
%           symbols. Note that the input length n is always defined as a
%           multiple of m
%
% Outputs:
%   seq_out: vector of size 1x(n/m) containing the output sequence

%% of Tuna Öztürk and Kerem Kaya

seq_in = uint8(seq_in(:).');
X = X(:).';
m = size(label, 2);
N = numel(seq_in) / m;

seq_out = zeros(1, N);

prev_symbol = 1;   % initial phase is 0

for k = 1:N

    bits = seq_in((k-1)*m + 1 : k*m);
    idx = find(ismember(label, bits, 'rows'));

    if isempty(idx)

        error('Input bit block does not match any label.');

    end

    rotation = X(idx);
    seq_out(k) = prev_symbol * rotation;
    prev_symbol = seq_out(k);

end

end

