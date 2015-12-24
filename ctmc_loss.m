function [loss] = ctmc_loss(Q, state_sets)
    
%     n = size(Q,1);
    m = state_sets.size();
    
    P = projection_matrix(state_sets);
    
    pi = ctmc_stationary(Q);
    Pi = diag(pi);
    
    P_left = (P'*Pi*P) \ (P'*Pi);
    Q_inv = pinv(Q);
    
    loss = 0;
    for fii_n = 1:m
        fii = state_sets.get(fii_n-1);
        p_fii = P_left(fii_n,:);
        for fij_n = 1:m
            fij = state_sets.get(fij_n-1);
            
            for i_idx = 1:fii.size()
                i = fii.get(i_idx-1);
                
                p_fii(i) = p_fii(i) - 1;
                
                s = 0;
                for j_idx = 1:fij.size()
                    j = fij.get(j_idx-1);
                    
                    s = s + p_fii*Q_inv(:,j);
                end
                
                p_fii(i) = p_fii(i) + 1;
                
                loss = loss + abs(s);
            end
        end
    end
end