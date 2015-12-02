function [P] = ctmc_future(Q, t)
    h = 1e-3 / norm(Q);
    n_steps = ceil(t / h);
    
    I = eye(size(Q,1));
    
    Q_step = I + Q*h;
    P = Q_step^n_steps;
%     
%     for i = 1:n_steps
%         P = P * Q_step;
%     end
end