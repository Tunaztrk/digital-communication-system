function [seq_out] = hd_diff(seq_in,X,label)
%HD_DIFF Performs hard-decision demapping for differentially encoded symbols.
%
% Inputs:
%   seq_in             - Received differential symbol sequence.
%   X                  - Reference constellation symbols.
%   label              - Binary labeling matrix for the constellation.
%
% Outputs:
%   seq_out            - Hard-decoded output bit sequence.
%

%% HD_DIFF Summary of this function goes here
% This code first recovers the transmitted phase change by comparing
% each received symbol to the previous one. Then it finds the nearest
% constellation point and outputs the corresponding bit label.
%

%% Explanation
% In the loop, we recover the differential phase symbol by comparing 
% the current received symbol to the previous one. Then we find the 
% nearest constellation point and copy its binary label to the output 
% bit sequence.
%

%% of Tuna Öztürk and Kerem Kaya

seq_in = seq_in(:).';
X = X(:).';
m = size(label, 2);
N = numel(seq_in);
seq_out = zeros(1, N*m, 'uint8');
prev_symbol = 1;   

for k = 1:N

    diff_symbol = seq_in(k) / prev_symbol;
    distances = abs(diff_symbol - X).^2;
    [~, idx] = min(distances);
    seq_out((k-1)*m + 1 : k*m) = uint8(label(idx, :));
    prev_symbol = seq_in(k);

end

end

