function seq_out = repetition(seq_in, n, k)
%REPETITION Encodes an input bit sequence using a repetition code.
%
% Inputs:
%   seq_in             - Input information-bit sequence.
%   n                  - Encoded block length.
%   k                  - Information block length.
%
% Outputs:
%   seq_out            - Repetition-coded output sequence.
%
%% Summary
% this function encodes a (n,k)-repetition code by repeating 
%  the input bit vector several times.
%
%% Explanation 
% firstly, the function computes the repetition factor nr = n/k. 
% after that, it creates the codeword by repeating the whole input 
% sequence nr times side by side using repmat. Finally, it returns
% the repeated sequence as a uint8 row vector.
%

%% of Tuna Öztürk and Kerem Kaya

seq_in = uint8(seq_in(:).');
nr = n / k;
seq_out = repmat(seq_in, 1, nr);
seq_out = uint8(seq_out);

end

