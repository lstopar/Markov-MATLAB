function [P] = projection_matrix(state_sets)
    m = state_sets.size();
    n = 0;
    for j = 1:m
        n = n + state_sets.get(j-1).size();
    end
    
    P = zeros(n,m);
    for j = 1:m
        state_set = state_sets.get(j-1);
        for i = 1:state_set.size()
            P(state_set.get(i-1),j) = 1;
        end
    end
end