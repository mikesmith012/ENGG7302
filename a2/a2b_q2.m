%% ENGG7302 Assignment 2 Part B Question 2
clear;


%% Perform Image Compression using SVD

% Load image
addpath("a2images/");
im = double(im2gray(imread("tigercub.jpg", "jpg")));

% Perform SVD
[U, S, V] = svd(im);

% Number of singular values
k = 50;

% Construct the compressed image
im_k = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';


%% Calculate Compression Ratio

% Original size
original_size = numel(im);

% Compressed size
compressed_size = k * (size(U, 1) + size(V, 1) + 1);

% Compression ratio
compression_ratio = 100 * compressed_size / original_size;


%% Compare compressed vs original image
figure;

% Original image
subplot(1, 2, 1);
imshow(uint8(im));
title("Original Image");

% Compressed image
subplot(1, 2, 2);
imshow(uint8(im_k));
title(sprintf("Compression ratio: %.2f%%, k = %d", compression_ratio, k));
