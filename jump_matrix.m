function [J] = jump_matrix(Q)
    n = size(Q,1);
    
    J = zeros(n);
    for i = 1:n
        if Q(i,i) == 1
            J(i,i) = 1;
        else
            for j = 1:n
                if i ~= j
                    J(i,j) = -Q(i,j) / Q(i,i);
                end
            end
        end
    end
end