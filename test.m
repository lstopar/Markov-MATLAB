%%
n = 7;
eps = 1e-2;
Q = [];

Q(1,2) = 10;
Q(2,1) = 8;
Q(2,3) = eps;
Q(3,2) = eps;
Q(3,4) = 5;
Q(4,3) = 10;
Q(4,5) = 7;
Q(5,4) = 5;
Q(5,3) = 9;
Q(5,7) = eps;
Q(7,5) = eps;
Q(7,6) = 140;
Q(6,7) = 100;

Q = Q - diag(sum(Q,2));

state_sets = java.util.ArrayList;
state_sets.add(java.util.ArrayList);
state_sets.add(java.util.ArrayList);
state_sets.add(java.util.ArrayList);
state_sets.get(0).add(1);
state_sets.get(0).add(2);
state_sets.get(1).add(3);
state_sets.get(1).add(4);
state_sets.get(1).add(5);
state_sets.get(2).add(6);
state_sets.get(2).add(7);

P = projection_matrix(state_sets);
Pi = diag(ctmc_stationary(Q));

[U,S,V] = svd(Q);
U = U(:,1:n-1);
S = S(1:n-1,1:n-1);
V = V(:,1:n-1);
Q_inv = V*diag(1 ./ diag(S))*U';