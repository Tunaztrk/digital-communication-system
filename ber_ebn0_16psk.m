%% BER vs. Eb/N0 for uncoded 16-PSK
% Uses the MATLAB modules contained in this repository:
%   src/modulation/get_gray_label.m
%   src/modulation/map_to_constellation.m
%   src/channel/get_N0.m
%   src/channel/awgn.m
%   src/demapping/hd.m

clear;
clc;
close all;

%% Locate repository and add required modules
script_path = mfilename('fullpath');
project_root = fileparts(script_path);

modulation_dir = fullfile(project_root, 'src', 'modulation');
channel_dir    = fullfile(project_root, 'src', 'channel');
demapping_dir  = fullfile(project_root, 'src', 'demapping');

addpath(modulation_dir);
addpath(channel_dir);
addpath(demapping_dir);

% Verify required project functions
required_functions = {
    'get_gray_label'
    'map_to_constellation'
    'get_N0'
    'awgn'
    'hd'
};

for i = 1:numel(required_functions)
    assert(~isempty(which(required_functions{i})), ...
        'Required function not found: %s', required_functions{i});
end

%% Simulation parameters
M = 16;                     % 16-PSK
m = log2(M);                % bits per symbol
coderate = 1;               % uncoded transmission
EbN0_dB = 0:1:16;           % Eb/N0 sweep [dB]
num_bits = 4e5;             % multiple of log2(M)

rng(1);                     % reproducible simulation

%% Build the 16-PSK constellation
k = 0:M-1;

X = exp(1j * 2*pi*k/M);
X = X / sqrt(mean(abs(X).^2));

label = get_gray_label(m);

%% Generate random information bits
num_bits = floor(num_bits/m) * m;

tx_bits = uint8(randi([0 1], 1, num_bits));

%% Map bits to 16-PSK constellation
tx_symbols = map_to_constellation(tx_bits, X, label);

%% Sweep Eb/N0 and estimate BER
BER = zeros(size(EbN0_dB));

for idx = 1:numel(EbN0_dB)

    N0 = get_N0( ...
        'ebn0', ...
        EbN0_dB(idx), ...
        M, ...
        X, ...
        coderate);

    rx_symbols = awgn(tx_symbols, N0);

    rx_bits = uint8( ...
        hd(rx_symbols, X, label) ...
    );

    BER(idx) = mean(rx_bits ~= tx_bits);

    fprintf( ...
        'Eb/N0 = %2d dB -> BER = %.6e\n', ...
        EbN0_dB(idx), ...
        BER(idx));
end

%% Plot BER curve
figure('Color', 'w');

semilogy( ...
    EbN0_dB, ...
    BER, ...
    'o-', ...
    'LineWidth', 1.5, ...
    'MarkerSize', 6);

grid on;

xlabel('E_b/N_0 [dB]');
ylabel('Bit Error Rate (BER)');

title('BER Performance of Uncoded 16-PSK over AWGN');

xlim([EbN0_dB(1) EbN0_dB(end)]);

%% Export for GitHub README
results_dir = fullfile(project_root, 'docs', 'results');

if ~exist(results_dir, 'dir')
    mkdir(results_dir);
end

exportgraphics( ...
    gcf, ...
    fullfile(results_dir, 'ber_ebn0_16psk.png'), ...
    'Resolution', 300);