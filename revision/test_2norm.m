
D = [
    1,  0,  0;
    0,  2,  0;
   -4,  0,  3;
];

norm(D, 1)
norm(D, inf)

sum(abs(D)>0, 2)
