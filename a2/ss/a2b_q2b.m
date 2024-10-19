
clear;

A = [1, 2, 3; 4, 5, 6];


SL = A*A';
u1 = SL(:, 1);
u2 = SL(:, 2);

SR = A'*A;
v1 = SR(:, 1);
v2 = SR(:, 2);
v3 = SR(:, 3);


eigL = sort(eig(SL), 'descend');
eigR = sort(eig(SR), 'descend');


sigma1 = sqrt(eigL(1));
sigma2 = sqrt(eigL(2));


[U, S, V] = svd(A);

