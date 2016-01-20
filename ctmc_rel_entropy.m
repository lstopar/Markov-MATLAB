function [val] = ctmc_rel_entropy(Q, state_sets)
    
    Qs = ctmc_join(Q, state_sets);

%     n = size(Q,1);
    ns = size(Qs,1);
    p = ctmc_stationary(Q);
    
    sum1 = 0;
    sum2 = 0;
    
    for psii_n = 1:ns
        psii = state_sets.get(psii_n-1);
        for psij_n = 1:ns
            psij = state_sets.get(psij_n-1);
            if psii_n ~= psij_n
                for in = 1:psii.size()
                    i = psii.get(in-1);
                    
                    q_i_psij = 0;
                    for jn = 1:psij.size()
                        j = psij.get(jn-1);
                        
                        q_i_psij = q_i_psij + Q(i,j);
                    end
                    
                    if q_i_psij ~= 0
                        sum1 = sum1 + p(i)*q_i_psij*log(q_i_psij / Qs(psii_n, psij_n));
                    end
                end
            end
        end
        
        for in = 1:psii.size()
            i = psii.get(in-1);
                        
            q_i_psii = 0;
            for jn = 1:psii.size()
                j = psii.get(jn-1);
                q_i_psii = q_i_psii + Q(i,j);
            end
            
            sum2 = sum2 + p(i)*(q_i_psii - Qs(psii_n, psii_n));
        end
    end
    
    val = sum1 + sum2;
end