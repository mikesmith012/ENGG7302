A = [
    1, 2, 3;
    4, 5, 6;
    7, 8, 9;
    1, 2, 3;
];

b = [0; 1; 3];

psinvA = inv(A' * A);

x = psinvA * A' * b;

[u, s, v] = svd(A);

% u = [
%     1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
%     1/sqrt(3),          0, -2/sqrt(6);
%     1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
% ];
% 
% v = [1, 0; 0, 1];
% 
% A = u*s*v;