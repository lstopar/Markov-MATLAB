function [hierarchy, heightV, hierarchV, losses, losses_alt, losses_state_based, Q_matrices] = ctmc_partition(Q)
    % partitioning
    n = size(Q,1);
    
    state_sets = java.util.ArrayList;
    Q_matrices = java.util.ArrayList;
    losses = zeros(n-1,1);
    losses_alt = zeros(n-1,1);
    losses_state_based = zeros(n-1,1);
    heightV = zeros(2*n-2,1);
    hierarchV = zeros(2*n-2,1);
    hierarchy = java.util.ArrayList;
    stateIdV = java.util.ArrayList;
    
    initial_partition = java.util.ArrayList;
    for i = 1:n
        initial_partition.add(i);
    end
    
    curr_state_id = 2*n-1;
    
    state_sets.add(initial_partition);
    losses(1) = ctmc_rel_entropy(Q, state_sets);
    heightV(curr_state_id) = losses(1);%inf;
    hierarchV(curr_state_id) = curr_state_id;
    stateIdV.add(2*n-1);

    split_n = 2;
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
                
                loss = ctmc_rel_entropy(Q, state_sets);
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
            
            set0 = java.util.HashSet;
            set1 = java.util.HashSet;
            
            state_sets.add(state_set0);
            state_sets.add(state_set1);
            for k = 1:size(Qi,1)
                if part(k) == 0
                    state_set0.add(state_set.get(k-1));
                    set0.add(state_set.get(k-1));
                else
                    state_set1.add(state_set.get(k-1));
                    set1.add(state_set.get(k-1));
                end
            end
            
            parentId = stateIdV.remove(best_i);
            state_sets0 = java.util.ArrayList;
            state_sets1 = java.util.ArrayList;
            for i = 1:n
                if ~set0.contains(i)
                    ss = java.util.ArrayList;
                    ss.add(i);
                    state_sets0.add(ss);
                end
                if ~set1.contains(i)
                    ss = java.util.ArrayList;
                    ss.add(i);
                    state_sets1.add(ss);
                end
            end
            state_sets0.add(state_set0);
            state_sets1.add(state_set1);
            
            if state_set0.size() == 1
                stateId = state_set0.get(0);
            else
                curr_state_id = curr_state_id - 1;
                stateId = curr_state_id;
            end
            stateIdV.add(stateId);
            hierarchV(stateId) = parentId;
            heightV(stateId) = ctmc_rel_entropy(Q, state_sets0);
            
            if state_set1.size() == 1
                stateId = state_set1.get(0);
            else
                curr_state_id = curr_state_id - 1;
                stateId = curr_state_id;
            end
            stateIdV.add(stateId);
            hierarchV(stateId) = parentId;
            heightV(stateId) = ctmc_rel_entropy(Q, state_sets1);

            losses(split_n) = best_loss;
            losses_alt(split_n) = heightV(stateId);
            losses_state_based(state_sets.size()) = best_loss;
            Q_matrices.add(ctmc_join(Q,state_sets));
            
%             scores.add(best_score);
            hierarchy.add(java.util.ArrayList(state_sets));
            split_n = split_n + 1;
            disp(num2str(split_n));
        end
    end
end