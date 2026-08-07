%SAVE_HUFFMAN_STATISTIC Builds and saves a Huffman model from empirical text-symbol statistics.
%
% Script: Executes the corresponding source-coding setup and saves generated data.
%
%% Objective
%  1. receive training text training_text.txt,
%  2. calculate empirical letter dist. of a text,
%  3. create a Huffman struct with calculated parameters and create_huffman.m
%  4. store Huffman structure in Huffman_text.mat

% careful: encoder should handle all input alphabet of 256 characters!

% 1. Paths
project_root = fileparts(fileparts(mfilename('fullpath')));
text_path = fullfile(project_root, 'files', 'training_text.txt');
save_path = fullfile(project_root, 'files', 'huffman_text.mat');

% 2. Read
fid = fopen(text_path, 'r');
if fid == -1
    error('Could not open training_text.txt.');
end
training_seq = fread(fid, '*uint8');
fclose(fid);

if isempty(training_seq)
    error('training_text.txt is empty.');
end

% 3. Define Parameters

M = uint8(0:255);
B = 1;

counts = histcounts(double(training_seq), 0:256);
pM = counts / sum(counts);

huffman_structure = helpers.create_huffman(M, pM, B);

% 4. Save
save(save_path, 'huffman_structure');