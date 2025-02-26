A = [1, 2; 1, 2];

b = [2; 4];

psinvA = inv(A' * A);

x = inv(A) * b;
