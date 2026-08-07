function [seq_out] = hd(seq_in,X,label)
%HD Performs hard-decision demapping using minimum Euclidean distance.
%
% Inputs:
%   seq_in             - Received symbol sequence.
%   X                  - Reference constellation symbols.
%   label              - Binary labeling matrix for the constellation.
%
% Outputs:
%   seq_out            - Hard-decoded output bit sequence.
%
%% Summary:
% This approach is called as Hard Decision, as we make a
% strict decision regarding a comparison between our value and a threshold
% value.

%% Detailed explanation goes here
% this function receives symbol values which are slightly derived
% from the actual constellation symbol values. Therefore, in order 
% to obtain a most possible true estimation, we would like to calculate 
% the minimum euclidean distance to assign the faulty symbol the true 
% bit codeword.The for loop therefore goes through all received symbols, 
% finds the closest constellation point for each of them, and writes its 
% bit label into the output This approach is called as Hard Decision, as 
% we make a strict decision regarding a comparison between our value and
% a threshold value.
%

%% of Tuna Öztürk and Kerem Kaya

seq_in = seq_in(:).';
X = X(:).';
N = numel(seq_in);  % received symbol number
m = size(label, 2); % bits per symbol number

seq_out = zeros(1,length(seq_in)*size(label,2));


for i = 1:N

    distances = abs(seq_in(i) - X).^2;
    [~, idx] = min(distances);
    seq_out((i-1)*m + 1 : i*m) = uint8(label(idx, :));

end 

end

