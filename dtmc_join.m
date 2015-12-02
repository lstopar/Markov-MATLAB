function [P1] = dtmc_join(P, join_v)
    n1 = length(join_v);    
    P1 = zeros(n1);
    
    p = dtmc_stationary(P);
    
    for i = 1:n1
        states_i = join_v{i};
        for j = 1:n1
            states_j = join_v{j};
            
            sum = 0;
            sump = 0;
            for k = 1:length(states_i)
                sumk = 0;
                for l = 1:length(states_j)
                    sumk = sumk + P(states_i{k},states_j{l});
                end
                
                sum = sum + p(states_i{k})*sumk;
                sump = sump + p(states_i{k});
            end
            P1(i,j) = sum / sump;
        end
    end
end