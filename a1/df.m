%% Function to numerically calculate the first order dirivative at a point
%
% Params:
%  -> x: array of x-values corresponding to the function "y"
%  -> y: 1D function
%  -> xi: index of the point of interest
%
% Returns:
%  -> dfx: first order derivative at the point "xi"
%
function dfx = df(x, y, xi)

    % Use forward difference when at the first element
    if xi == 1
        xp_forward = x(xi + 1);
        yp_forward = y(xi + 1);
        dfx = (yp_forward - y(xi)) / (xp_forward - x(xi));

    % Use reverse difference when at the last element
    elseif xi == length(x)
        xp_reverse = x(xi - 1);
        yp_reverse = y(xi - 1);
        dfx = (y(xi) - yp_reverse) / (x(xi) - xp_reverse);
    
    % Use central difference for all other cases
    else
        xp_forward = x(xi + 1);
        xp_reverse = x(xi - 1);
        yp_forward = y(xi + 1);
        yp_reverse = y(xi - 1);
        dfx = (yp_forward - yp_reverse) / (xp_forward - xp_reverse);

    end
end