%% Function to implement the Golden Section Search
%
% Params:
%  -> y: 1D function to be optimised
%  -> a: x-value start point of function y
%  -> b: x-value end point of function y
%  -> tol: space between x-value points
%
% Returns:
%  -> x0: global maxima of function y
%
function x0 = GoldenSectionSearch(y, a, b, tol)

    % define the golden ratio "tau"
    tau = (sqrt(5) - 1)/2;

    % specify the initial two points "x1" and "x2" based on the golden ratio
    x1 = a + (1 - tau)*(b - a);
    x2 = a + tau*(b - a);

    % find the value of the function y, "f1" and "f2", at respective points "x1" and "x2"
    f1 = y(floor(x1/tol));
    f2 = y(floor(x2/tol));
    
    % keep looping until opt point converges
    while b - a > tol

        % if point 2 > point 1: ignore region between "x1" and "a" next time
        if f1 < f2
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = a + tau*(b - a);
            f2 = y(floor(x2/tol));

        % if point 1 > point 2: ignore region between "x2" and "b" next time
        else
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = a + (1 - tau)*(b - a);
            f1 = y(floor(x1/tol));
        end
    end

    % return the opt point
    x0 = a;
end