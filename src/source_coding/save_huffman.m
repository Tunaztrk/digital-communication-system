%SAVE_HUFFMAN Configures a discrete memoryless source example and saves its Huffman structure.
%
% Script: Executes the corresponding source-coding setup and saves generated data.
%
M = [0 1 2];
B = 2 ;
pM = [0.27 0.46 0.27];

huffman_structure = helpers.create_huffman(M, pM, B);

save('files/huffman_dms.mat', 'huffman_structure');
