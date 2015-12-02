function [ht] = holding_times(Q)
    n = size(Q,1);
    
    ht = zeros(1,n);
    for i = 1:n
        ht(i) = -1 / Q(i,i);
    end
end