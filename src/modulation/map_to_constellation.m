function [seq_out] = map_to_constellation(seq_in,X,label)
%MAP_TO_CONSTELLATION Maps a binary input sequence to symbols of a labeled constellation.
%
% Inputs:
%   seq_in             - Binary input sequence.
%   X                  - Constellation symbols.
%   label              - Binary labeling matrix.
%
% Outputs:
%   seq_out            - Mapped constellation-symbol sequence.
%
%MAP_TO_CONSTELLATION This function maps a binary input sequence to a
%sequence of symbols from a given constellation using a specified label.
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

seq_out = zeros(1,length(seq_in)/size(label,2));

seq_in = uint8(seq_in(:).');
m = size(label, 2);
num_symbols = numel(seq_in) / m;
bit_blocks = reshape(seq_in, m, num_symbols).';

% use the label table to compare each block
[is_valid, loc] = ismember(bit_blocks, label, 'rows');
seq_out = X(loc);

end

