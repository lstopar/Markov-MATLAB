function [d, table] = test_warp()
    seq1 = [
        1, 2, 1, 3
        2, 1, 2, 1.5
    ];
    seq2 = [
        1, 2, 1, 2, 1, 2, 1, 3, 4, 1, 3, 2, 1
        1, .2, .9, .98, .9, .2, 1, 1.8, .5, .1, 1, 1, .1
    ];

    function [d] = dist_fun(s1, dur1, s2, dur2)
        % we have an exponential model, so take it into account
        if s1 == s2
            d = 0;
        else
            d = min(dur1, dur2);
        end
    end

    [d, table] = dyn_time_warp_var_len(seq1, seq2, @dist_fun);
    
end