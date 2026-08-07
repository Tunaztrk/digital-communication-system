%SAVE_HUFFMAN_IMG Builds and saves a Huffman model for differential image coding.
%
% Script: Executes the corresponding source-coding setup and saves generated data.
%
%% Objectives
% 1. load the image
% 2. generate diff. image: each column from 2. depicts the difference of
% the absolute value of its own from its predecessor.
% 3. calculate the emp. dist. (pM) of each pixel (of family M with card. 256)
% 4. save at files/huffman.img.mat

%% 1. Paths

project_root = fileparts(fileparts(mfilename('fullpath')));
image_path = fullfile(project_root, 'files', 'peppers.pgm');
save_path = fullfile(project_root, 'files', 'huffman_img.mat');


%% 2. Read Image

img = imread(image_path);

if ndims(img) ~= 2
    error('Input image must be grayscale (2D).');
end

img = uint8(img);

%% 3. Differential Image

img_diff = zeros(size(img), 'uint8');

img_diff(:,1) = img(:,1);

if size(img,2) > 1

    img_diff(:,2:end) = uint8(...
    ...
    mod(double(img(:,2:end)) - double(img(:,1:end-1)), 256));

end

%% 4. Huffman Tree Parameters

%convert image into a sequence for tree struct
huffman_seq = img_diff(:); 

M = uint8(0:255);
B = 1;

counts = histcounts(double(huffman_seq), 0:256);
pM = counts / sum(counts);

huffman_structure = helpers.create_huffman(M,pM,B);

%% 5. Save

% metadata, suggested by AI after check_report

huffman_structure.image_height = size(img,1);
huffman_structure.image_width  = size(img,2);
huffman_structure.transform    = 'first column original, others modulo-256 horizontal difference';

save(save_path, 'huffman_structure');
