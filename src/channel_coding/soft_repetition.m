function [seq_out] = soft_repetition(seq_in,n,k)
%SOFT_REPETITION Decodes a repetition code from soft information by combining LLR values.
%
% Inputs:
%   seq_in             - Input log-likelihood-ratio sequence.
%   n                  - Encoded block length.
%   k                  - Information block length.
%
% Outputs:
%   seq_out            - Decoded information bits.
%
%% SOFT_REPETITION Summary 
% this function decodes a repetition code from soft information by
% summing LLRs of repeated bits.
%
%
%% Explanation 
% the function reshapes the input LLR sequence into a k x nr matrix, so that 
% each row contains all LLRs belonging to one repeated information bit. After 
% it does the LLRs row-wise sum, it combines the reliability information from
% all repetitions. If the total LLR is positive, the decoded bit is 0; else, 
% the decoded bit is 1. This method is more powerful than hard-decision decoding 
% because it keeps the reliability information instead of reducing everything to
% plain bits first.
%
%

%% of Tuna Öztürk and Kerem Kaya

seq_out = uint8(zeros(1,k));
seq_in = seq_in(:).';

nr = n / k;

llr_matrix = reshape(seq_in, k, nr);
llr_sum = sum(llr_matrix, 2);

seq_out(llr_sum < 0) = 1;


end

