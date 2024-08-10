%% Function to numerically calculate the second order dirivative at a point
%
% Params:
%  -> x: array of x-values corresponding to the function "y"
%  -> y: 1D function
%  -> xi: index of the point of interest
%
% Returns:
%  -> ddfx: second order derivative at the point "xi"
%
function ddfx = ddf(x, y, xi)

    % second-order derivative is not defined at the boundary
    if xi == 1 || xi == length(x)
        warning("Second order derivative is not defined at the boundary.");
    
    % use central difference for all other cases
    else
        xp_forward = x(xi + 1);
        xp_reverse = x(xi - 1);
        xp_current = x(xi);

        yp_forward = y(xi + 1);
        yp_reverse = y(xi - 1);
        yp_current = y(xi);

        ddfx = (yp_forward - 2*yp_current + yp_reverse) / ((xp_forward - xp_current)*(xp_current - xp_reverse));
    end
end