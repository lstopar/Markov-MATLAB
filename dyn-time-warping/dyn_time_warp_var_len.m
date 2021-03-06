function [dist, table] = dyn_time_warp_var_len(ref_seq, obs_seq, dist_fun)
    % prototype implementation of dynamic timewarping
    % the algorithm computes a distance-like measure between time sequences
    % the sequences are represented using two matrices: seq1, seq2, where
    % - seq1(1,i) contains the symbol ID
    % - seq1(2,i) contains the duration of the i-th symbol in sequence 1
    % - dist_fun is the distance function in the form of function (s1, dur1, s2, dur2)
    
    symbol1 = ref_seq(1,:);
    symbol2 = obs_seq(1,:);
    dur1 = ref_seq(2,:);
    dur2 = obs_seq(2,:);
    
    n = length(dur1);
    m = length(dur2);
    
    table = zeros(n+1, m+1);
    
    for i = 1:n+1
        table(i,1) = inf;
    end
    
    for j = 1:m+1
        table(1,j) = inf;
    end
    table(1,1) = 0;
    
    curr_best = inf;
    last_j = m+1;
    for j = 1:m
        for i = 1:n
            prev = min(min(table(i,j), table(i+1,j)), table(i,j+1));
            dist = dist_fun(symbol1(i), dur1(i), symbol2(j), dur2(j));
            table(i+1,j+1) = prev + dist;
        end
        
        if table(end,j+1) < curr_best
            curr_best = table(end,j+1);
        end
        
        % check if we can still get a better result than the one we already
        % have
        is_done = true;
        for i = 1:n
            if table(i,j+1) <= curr_best
                is_done = false;
            end
        end
        
        if is_done
            last_j = j+1;
            break;
        end
    end
    
    dist = table(end,last_j);
end