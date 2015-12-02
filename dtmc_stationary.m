function [p] = dtmc_stationary(P)
    eps = 1e-8 * norm(P);
    n = size(P,1);
    
    [V,D] = eig(P');
    
    lambda = 1;
    for i = 1:n
        if abs(D(i,i) - lambda) < eps
            p = abs(V(:,i))';
        end
    end
    
    p = p ./ norm(p,1);
end