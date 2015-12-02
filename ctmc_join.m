function [Q1] = ctmc_join(Q, state_sets)
    n1 = state_sets.size();
    Q1 = zeros(n1);
    
    p = ctmc_stationary(Q);
    
    for i = 1:n1
        states_i = state_sets.get(i-1);%join_v{i};
        for j = 1:n1
            states_j = state_sets.get(j-1);%join_v{j};
            
            sum = 0;
            sump = 0;
            for k = 1:states_i.size()
                sumk = 0;
                for l = 1:states_j.size()
                    sumk = sumk + Q(states_i.get(k-1),states_j.get(l-1));
                end
                
                sum = sum + p(states_i.get(k-1))*sumk;
                sump = sump + p(states_i.get(k-1));
            end
            Q1(i,j) = sum / sump;
        end
    end
end