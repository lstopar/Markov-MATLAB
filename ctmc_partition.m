function [hierarchy, losses, Q_matrices] = ctmc_partition(Q)
    n = size(Q,1);
    
    state_sets = java.util.ArrayList;
    Q_matrices = java.util.ArrayList;
    losses = zeros(n-1,1);
    hierarchy = java.util.ArrayList;
    
    initial_partition = java.util.ArrayList;
    for i = 1:n
        initial_partition.add(i);
    end
    
    state_sets.add(initial_partition);

    split_n = 1;
    best_loss = 0;
    while best_loss ~= inf
        best_i = -1;
        best_loss = inf;
        
        for i = 0:state_sets.size()-1
            state_set = state_sets.remove(i);
            if state_set.size() > 1                
                Qi = ctmc_subprocess(Q, state_set);
                part = ctmc_bipartition(Qi);
                
                state_set0 = java.util.ArrayList;
                state_set1 = java.util.ArrayList;
                state_sets.add(state_set0);
                state_sets.add(state_set1);
                
                for k = 1:size(Qi,1)
                    if part(k) == 0
                        state_set0.add(state_set.get(k-1));
                    else
                        state_set1.add(state_set.get(k-1));
                    end
                end
                
                loss = ctmc_loss(Q, state_sets);
                if loss < best_loss
                    best_loss = loss;
                    best_i = i;
                end
                
                state_sets.remove(state_sets.size()-1);
                state_sets.remove(state_sets.size()-1);
            end
            state_sets.add(i, state_set);
        end
        
        if best_loss ~= inf
            state_set = state_sets.remove(best_i);
            Qi = ctmc_subprocess(Q, state_set);
            part = ctmc_bipartition(Qi);

            state_set0 = java.util.ArrayList;
            state_set1 = java.util.ArrayList;
            state_sets.add(state_set0);
            state_sets.add(state_set1);
            for k = 1:size(Qi,1)
                if part(k) == 0
                    state_set0.add(state_set.get(k-1));
                else
                    state_set1.add(state_set.get(k-1));
                end
            end

            losses(split_n) = best_loss;
            Q_matrices.add(ctmc_join(Q,state_sets));
            
%             scores.add(best_score);
            hierarchy.add(java.util.ArrayList(state_sets));
            split_n = split_n + 1;
        end
    end
end