function [part, lambda2, v2] = ctmc_bipartition(Q)
    % partitions the CTMC into 2 partitions
    % Q is the negative laplacian of the
    % bi-grap induced by the Markov chain
    n = size(Q,1);
    
    p = ctmc_stationary(Q);
    Pi = diag(p);
    
    Qs = (Pi*Q + Q'*Pi) / 2;
    
    [V, D] = eig(Qs, Pi);
    lambda = diag(D);
    
    % if we order the eigenvalues of the
    % laplacian as: l1 <= l2 <= ... <= ln
    % then we are interested in the eigenvector
    % associated with the second smallest eigenvalue
    % our ordering is however reverse, so we are interested
    % in the second largest eigenvalue
    [lambda, idxs] = sort(lambda);
    V = V(:, idxs);
    
    v2 = V(:,n-1);
    lambda2 = lambda(n-1);
    part = v2 >= 0;
end