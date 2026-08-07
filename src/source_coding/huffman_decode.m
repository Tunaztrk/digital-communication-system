function [output] = huffman(huffman_structure,input_seq)
%HUFFMAN_DECODE Decodes a Huffman-coded bit sequence by traversing the stored Huffman tree.
%
% Inputs:
%   huffman_structure  - Huffman coding structure.
%   input_seq          - Encoded Huffman bit sequence.
%
% Outputs:
%   output             - Decoded source-symbol sequence.
%
%% DECODER
%% Objective:
% decoder obtains the input code sequence, according to input code decoder
% traverses the tree, outputs the block of the leaf. returns to root and 
% re-executes the task as one block is extracted 

        tree = huffman_structure.tree;
        root_id = huffman_structure.root_id;
        blocks = huffman_structure.blocks;

        %% 1) Decode bit by bit by traversing the Huffman tree
        decoded_symbols = [];

        current_node = root_id;

        for i = 1:numel(input_seq)
            bit = input_seq(i);

            if bit == 0
                current_node = tree(current_node).left;
            else
                current_node = tree(current_node).right;
            end

            % If we reached a leaf, append its block and restart from root
            if tree(current_node).is_leaf
                leaf_idx = tree(current_node).symbol_index;
                decoded_block = blocks(leaf_idx, :);

                decoded_symbols = [decoded_symbols, decoded_block]; %#ok<AGROW>
                current_node = root_id;
            end
        end

        % Valid Huffman stream must end exactly at the root after decoding
        if current_node ~= root_id
            error('enc_seq ended in the middle of a Huffman codeword.');
        end

        % Return
        output = uint8(decoded_symbols);
    end
