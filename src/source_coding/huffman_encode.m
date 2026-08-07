function [output] = huffman(huffman_structure, input_seq)
%HUFFMAN_ENCODE Encodes a source sequence using a precomputed block Huffman code.
%
% Inputs:
%   huffman_structure  - Huffman coding structure.
%   input_seq          - Source-symbol sequence to encode.
%
% Outputs:
%   output             - Huffman-coded bit sequence.
%
%% ENCODER
%% IDEA

% divide the sequence into blocks, find all blocks in the block table to
% allocate the corresponding code, stack the found huffman codes next to 
% each other in a sequence of uint8 type

% Code:
input_seq = double(input_seq(:).');
B = double(huffman_structure.B);
blocks_ref = double(huffman_structure.blocks);
blocks_ref = reshape(blocks_ref, [], B); % for error occurred in 2.2), otherwise row/column matrix shapes don't align
codes_ref  = huffman_structure.codes;

% if the sequence length not compatible with block length
if mod(numel(input_seq), B) ~= 0
    error('Length of input_seq must be a multiple of B.');
end

num_input_blocks = numel(input_seq) / B;
input_blocks = reshape(input_seq, B, num_input_blocks).';

%compare with the reference

[is_valid, loc] = ismember(input_blocks, blocks_ref, 'rows');

if ~all(is_valid)
    error('input_seq contains a block that is not present in huffman_structure.blocks.');
end

%for output
total_bits = 0;
for k = 1:num_input_blocks
    total_bits = total_bits + numel(codes_ref{loc(k)});
end

output = zeros(1, total_bits, 'uint8');
pos = 1;

for k = 1:num_input_blocks
    current_code = uint8(codes_ref{loc(k)});
    L = numel(current_code);
    output(pos:pos+L-1) = current_code;
    pos = pos + L;
end

%% the output is a one dimensional bit sequence
end

