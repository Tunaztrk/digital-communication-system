function [seq_out] = hard_repetition(seq_in,n,k)
%HARD_REPETITION Decodes a repetition code from hard decisions using majority voting.
%
% Inputs:
%   seq_in             - Received hard-decision bit sequence.
%   n                  - Encoded block length.
%   k                  - Information block length.
%
% Outputs:
%   seq_out            - Decoded information bits.
%
%% HARD_REPETITION Summary 
% This function decodes a repetition code from hard bit decisions
% by applying majority voting, which is doing a decision regarding 
% an threshold value.
%
%
%% Explanation
% the function reshapes the received sequence into a k x nr matrix, 
% where each row contains all repeated versions of one original 
% information bit. For each row, it counts how many ones were received.
% If the number of ones is at least half of the repetitions, it decides 
% for 1; else for 0. In this way, the redundancy is used to correct bit 
% errors by majority vote. So it really does make the code more robust.
%

%% of Tuna Öztürk and Kerem Kaya

seq_out = uint8(zeros(1,k));

nr = n / k;
seq_matrix = reshape(seq_in, k, nr);
num_ones = sum(seq_matrix, 2);

seq_out = zeros(1, k, 'uint8');

seq_out(num_ones >= nr/2) = 1;

end

