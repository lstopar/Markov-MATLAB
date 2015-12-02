function [Qs] = ctmc_subprocess(Q, state_set)
    ni = state_set.size();
        
    Qs = zeros(ni);

    for i = 1:ni
        for j = 1:ni
            if i ~= j
                Qs(i,j) = Q(state_set.get(i-1), state_set.get(j-1));
            end
        end
    end

    Qs = Qs - diag(sum(Qs, 2));
end