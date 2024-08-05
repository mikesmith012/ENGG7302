function [c] = mult_matrix(a, b)

    size_a = size(a);
    size_b = size(b);

    if size_a(2) ~= size_b(1)
        c = -1;
    else
        c = zeros(size_a(1), size_b(2));
        for i = 1:size_a(1)
            for j = 1:size_b(2)
                c(i, j) = a(i, :) * b(:, j);
            end
        end
    end

end 