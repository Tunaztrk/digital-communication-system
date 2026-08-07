function [X, label] = get_qam(M)
%GET_QAM Generates a square M-QAM constellation with Gray labeling.
%
% Inputs:
%   M                  - Constellation order.
%
% Outputs:
%   X                  - QAM constellation symbols.
%   label              - Gray labeling matrix.
%
%GET_QAM Initializes a square M-QAM constellation with Gray labeling
%
% Inputs:
%   M     : constellation order, must be a square power of 2
%
% Outputs:
%   X     : row vector containing the M QAM symbols
%   label : M x m matrix containing Gray labels

%% of Tuna Öztürk and Kerem Kaya
%% for the code to function, M must be a power of 4 integer !!


L = sqrt(M);
m = log2(M);
levels = -(L-1):2:(L-1);
X = zeros(1, M);
idx = 1;

for q = 1:L
    for i = 1:L
        X(idx) = levels(i) + 1j*levels(L-q+1);
        idx = idx + 1;
    end
end

    X = X / sqrt(mean(abs(X).^2));

label = modulation.get_gray_label(m);

end