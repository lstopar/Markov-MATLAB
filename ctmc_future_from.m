function [p] = ctmc_future_from(i, Q, t)
    P_n = ctmc_future(Q,t);
    p = P_n(i,:);
end