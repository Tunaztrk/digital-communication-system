function [output] = huffman_img(huffman_structure, img_width, img_height, input_seq)
%HUFFMAN_ENCODE_IMG Differentially encodes an image and applies Huffman source coding.
%
% Inputs:
%   huffman_structure  - Huffman coding structure.
%   img_width          - Image width.
%   img_height         - Image height.
%   input_seq          - Input image samples as a sequence.
%
% Outputs:
%   output             - Huffman-coded differential image sequence.
%

%% Objective
% calculate differential image and encode the image

img = reshape(input_seq, [img_width, img_height]).';
img = uint8(img);

% differential image (as in save_huffman_img.m)

img_diff = zeros(size(img), 'uint8');
img_diff(:,1) = img(:,1);

if size(img,2) > 1
    img_diff(:,2:end) = uint8(mod( ...
    double(img(:,2:end)) - double(img(:,1:end-1)), 256));
end

diff_seq = img_diff.';
diff_seq = diff_seq(:);

%% Compression with Huffman Encoder

output = source_encoding.huffman(huffman_structure, diff_seq);

output = uint8(output);

end