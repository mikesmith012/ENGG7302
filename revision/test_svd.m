%A = [sqrt(2), -sqrt(2); -sqrt(2), sqrt(2)];
%A = [1, 2; 2, 3; 3, 4];


u = [
    1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
    1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
    1/sqrt(3),          0, -2/sqrt(6);
];

s = [
    sqrt(3),       0;
          0, sqrt(2);
          0,       0;
];

v = [1, 0; 0, 1];

disp(u * s * v');

s = [3, 0, 0; 0, 2, 0; 0, 0, 1];
v = [-1/sqrt(2), 0, 1/sqrt(2); 0, 1, 0; -1/sqrt(2), 0, -1/sqrt(2);];
u = eye(3);

A = u * s * v'; disp(A);

disp(A * v');
disp(inv(v' * A));
disp(v' * inv(A));