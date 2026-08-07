function huffman_structure = create_huffman(M, pM, B)
%CREATE_HUFFMAN Builds a block-based Huffman coding structure from a source alphabet and probabilities.
%
% Inputs:
%   M                  - Source alphabet.
%   pM                 - Source-symbol probabilities.
%   B                  - Source block length.
%
% Outputs:
%   huffman_structure  - Huffman tree, codewords, blocks and associated metadata.
%

%% of Tuna Öztürk and Kerem Kaya

%% 1 :: Generate all length-B source blocks and corresponding probabilities

K = numel(M);

grids = cell(1, B);
grid_inputs = repmat({1:K}, 1, B);
[grids{:}] = ndgrid(grid_inputs{:});

num_blocks = K^B;
index_matrix = zeros(num_blocks, B);

for b = 1:B
    index_matrix(:, b) = grids{b}(:);
end

blocks = reshape(M(index_matrix), [], B);

% probability of each block
pM = pM(:).';              % force row vector
prob_matrix = reshape(pM(index_matrix(:)), num_blocks, B);;
pblocks = prod(prob_matrix, 2);

%% 2 :: Build Huffman tree
% first, definition of the leaves and their properties

num_leaves = numel(pblocks);

% allocate all leaves of binary tree
tree (2*num_leaves-1) = struct(...
    'prob', [], ...
    'left', [], ...
    'right', [], ...
    'symbol_index',[], ...
    'is_leaf', []);

% establish all the leaf nodes

for i=1:num_leaves
    tree(i).prob = pblocks(i);
    tree(i).left = [];
    tree(i).right = [];
    tree(i).symbol_index = i;
    tree(i).is_leaf = true;
end

active = 1:num_leaves;
next_id = num_leaves + 1;

%iterative merge
while numel(active) > 1
    active_probs = arrayfun(@(idx) tree(idx).prob, active);
    %sort by ascending probability
    [~, order] = sort(active_probs, 'ascend');
    active = active(order);

    id1 = active(1);
    id2 = active(2);

    %creating a parent node
    tree(next_id).prob = tree(id1).prob + tree(id2).prob;
    tree(next_id).left = id1;
    tree(next_id).right = id2;
    tree(next_id).symbol_index = [];
    tree(next_id).is_leaf = false; %bc interior node

    % update merged nodes
    active = [active(3:end), next_id];
    next_id = next_id + 1;

end

root_id = active;
tree = tree(1:next_id-1);

%tree established

%% 3 :: assign bit codes for each block

% for traversing
    function traverse (node_id, current_code)
        if tree(node_id).is_leaf
            leaf_idx = tree(node_id) .symbol_index;
            codes{leaf_idx} = current_code;
            return;
        end 
        traverse(tree(node_id).left, [current_code 0]);
        traverse(tree(node_id).right, [current_code 1]);
    end

codes = cell(num_leaves, 1);
if tree(root_id).is_leaf
    codes{tree(root_id).symbol_index} = 0;
else
    traverse(root_id, []);
end

%% 4 :: Store everything in output struct
huffman_structure = struct();
huffman_structure.B = B;
huffman_structure.M = M;
huffman_structure.pM = pM;
huffman_structure.blocks = blocks;
huffman_structure.pblocks = pblocks;
huffman_structure.codes = codes;
huffman_structure.tree = tree;
huffman_structure.root_id = root_id;

end
