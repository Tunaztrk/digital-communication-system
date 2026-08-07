function [output] = huffman_img(huffman_structure, img_width, img_height, encoded_seq)
%HUFFMAN_IMG Decodes a Huffman-coded differential image and reconstructs the original image.
%
% Inputs:
%   huffman_structure  - Huffman coding structure.
%   img_width          - Image width.
%   img_height         - Image height.
%   encoded_seq        - Encoded differential image sequence.
%
% Outputs:
%   output             - Reconstructed image sequence.
%

%% Objective 
%  reconstruct the differential image and restore the original image from
%  differential image

diff_seq = source_decoding.huffman(huffman_structure, encoded_seq);
diff_seq = uint8(diff_seq);

if numel(diff_seq) ~= img_width * img_height
    error('Decoded differential sequence length does not match image dimensions.');
end
% return to matrix form
 diff_img = reshape(diff_seq, [img_width, img_height]).';

%% Reconstruction

 img = zeros(size(diff_img), 'uint8');
 img(:,1) = diff_img(:,1);
 % reverse the operation iterative
 for col = 2:img_width
     img(:,col) = uint8(mod(double(img(:,col-1)) + double(diff_img(:,col)), 256));
 end

 
 output = img.';
 output = output(:);
 output = uint8(output);
end