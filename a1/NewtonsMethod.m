%% Function to implement the Newton's Method Search
%
% Params:
%  -> x: array of x-values corresponding to the function "y"
%  -> y: 1D function to be optimised
%  -> a: x-value start point of function y
%  -> b: x-value end point of function y
%  -> n: number of iterations
%  -> tol: space between x-value points
%
% Returns:
%  -> %  -> x0: global maxima of function y
%
function x0 = NewtonsMethod(x, y, a, b, n, tol)

    % select a starting point to be halfway between the endpoints
    x0 = (a + b)/2; 

    % loop for "n" number of iterations
    for i = 1:n

        % convert x-value to x-index
        xi = floor(x0/tol); 

        % apply Newton's Method algorithm
        x0 = x0 - df(x, y, xi) ./ ddf(x, y, xi);
    end
end