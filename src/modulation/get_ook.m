function [X,label] = get_ook()
%GET_OOK Generates a unit-average-power on-off keying constellation and labels.
%
% Inputs: None.
%
% Outputs:
%   X                  - OOK constellation symbols.
%   label              - Binary labeling matrix.
%
%GET_OOK Initialization of On-Off-Keying (OOK) constellation. Outputs the
%points and labels of an OOK constellation with unit average power.
%
% Outputs:
%   X:      Vector of dimension 1xM containing the M symbols of the OOK
%           constellation
%   label:  Matrix of size Mxm containing the binary labels of the OOK
%           symbols where m=log2(M)

%% of Tuna Öztürk and Kerem Kaya

X = [0, sqrt(2)];
label = [0;1];

end

