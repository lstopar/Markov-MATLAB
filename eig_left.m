function [V, D] = eig_left(Q)
    [V,D] = eig(Q');
    V = V';
end