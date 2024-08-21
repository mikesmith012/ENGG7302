function xx = parab(a0, b0, c0, n)

    xx = zeros(n, 1);

    a = a0; b = b0; c = c0;

    fa = f1(a);
    fb = f1(b);
    fc = f1(c);

    for i = 1:n

        x = b - ((fb-fc)*(b-a)^2 - (fb-fa)*(b-c)^2) / ...
                (2*((fb-fc)*(b-a) - (fb-fa)*(b-c)));

        fx = f1(x);

        if x > b
            if fx > fb
                c = x;
                fc = fx;
            else 
                a = b;
                fa = fb;
                b = x;
                fb = fx;
            end
        else
            if fx > fb
                a = x;
                fa = fx;
            else
                c = b;
                fc = fb;
                b = x;
                fb = fx;
            end
        end
        xx(i, 1) = x;
    end
end