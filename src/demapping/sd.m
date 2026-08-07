function [seq_out] = sd(seq_in,X,label,N0)
%SD Performs soft demapping and computes bit-wise log-likelihood ratios.
%
% Inputs:
%   seq_in             - Received symbol sequence.
%   X                  - Reference constellation symbols.
%   label              - Binary labeling matrix for the constellation.
%   N0                 - Noise power spectral density parameter.
%
% Outputs:
%   seq_out            - Bit-wise log-likelihood ratios.
%
%% SD Summary
% This function performs soft demapping and outputs bit-wise 
% log-likelihood ratios (LLRs).
%
%% Explanation 
% for each received symbol, the function computes a likelihood value 
% for every constellation point based on its Euclidean distance to the 
% received symbol and the noise level N0, unlike in hard decision which 
% does the operaiton just for the regarding symbol. Then, for each bit 
% position, it separates all constellation symbols into two groups: 
% 
% those with bit 0 at that position 
% those with bit 1. 
% 
% It sums the likelihoods of both groups and computes the logarithm of their 
% ratio. This gives the LLR for that bit. A positive LLR means bit 0 is more 
% likely, while a negative LLR means bit 1 is more likely.
%
%

%% of Tuna Öztürk and Kerem Kaya

seq_out = zeros(1,length(seq_in)*size(label,2));
seq_in = seq_in(:).';

X = X(:).';
m = size(label, 2);
N = numel(seq_in);

for i = 1:N

    y = seq_in(i);
    metric = exp(-abs(y - X).^2 / N0);

    for j = 1:m

        idx0 = (label(:, j) == 0);
        idx1 = (label(:, j) == 1);

        p0 = sum(metric(idx0));
        p1 = sum(metric(idx1));

        p0 = max(p0, realmin);
        p1 = max(p1, realmin);

        seq_out((i-1)*m + j) = log(p0 / p1);

    end

end

end

