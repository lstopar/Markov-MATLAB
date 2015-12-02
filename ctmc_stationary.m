function p = ctmc_stationary(Q)
%     n = size(Q,1);
% 
%     J = jump_matrix(Q);
%     
%     p = dtmc_stationary(J);
%     
%     for i = 1:n
%         p(i) = -p(i) / Q(i,i);
%     end
%     
%     p = p ./ norm(p,1);
    
    lambda = 0;

    dim = size(Q,1);
    eps = 1e-8;
    normQ = norm(Q);
    
    % A - lambda*I
    A = Q' - lambda*eye(dim);
    
    [L,U] = lu(A);

    function [ret] = sgn(val)
        if val >= 0
            ret = 1;
        else
            ret = -1;
        end
    end
    
    for i = 1:dim
        if abs(U(i,i)) < eps*normQ
            U(i,i) = sgn(U(i,i))*eps*normQ;
        end
    end
    
    
    A = L*U;
    
    p = U \ ones(dim,1);
    p = p / norm(p, 1);
    
    dist = inf;
    while dist > 1e-3
        p1 = p;
        p = A \ p;
%         p = p / norm(p);
        p = p / sum(p);
        dist = norm(p - p1);
    end
    
    p = p' / sum(p);
end