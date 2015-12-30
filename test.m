%% generate test data
n = 7;
eps = 1e-2;
Q = [];

% states aggregated states will be [1,2],[3,4,5],[6,7]

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

Q_test = [-31882.13772,0.00000,10000.00000,722.70546,10000.00000,1159.43226,0.00000,10000.00000,0.00000,0.00000,0.00000,0.00000; 0.00000,-11538.67583,0.00000,0.00000,0.00000,0.00000,1538.67583,0.00000,10000.00000,0.00000,0.00000,0.00000; 10000.00000,0.00000,-33299.41289,3299.41289,0.00000,0.00000,10000.00000,10000.00000,0.00000,0.00000,0.00000,0.00000; 804.41702,10000.00000,2241.31513,-23045.73215,0.00000,10000.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000; 10000.00000,0.00000,0.00000,0.00000,-21079.36030,10000.00000,0.00000,1079.36030,0.00000,0.00000,0.00000,0.00000; 676.48010,0.00000,676.48010,10000.00000,10000.00000,-21352.96020,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000; 0.00000,973.67956,0.00000,0.00000,0.00000,0.00000,-30973.67956,0.00000,10000.00000,10000.00000,10000.00000,0.00000; 10000.00000,0.00000,10000.00000,0.00000,3020.23378,0.00000,0.00000,-23020.23378,0.00000,0.00000,0.00000,0.00000; 0.00000,10000.00000,0.00000,3960.20718,0.00000,10000.00000,10000.00000,0.00000,-55353.94287,10000.00000,1393.73569,10000.00000; 0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,10000.00000,0.00000,10000.00000,-32887.62630,10000.00000,2887.62630; 0.00000,0.00000,10000.00000,0.00000,0.00000,0.00000,10000.00000,0.00000,1916.82494,10000.00000,-31916.82494,0.00000; 0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,10000.00000,3300.64716,0.00000,-13300.64716];
state_sets_test = java.util.ArrayList;
state_sets_all = java.util.ArrayList;

state_sets_test.add(java.util.ArrayList);
state_sets_test.add(java.util.ArrayList);
state_sets_all.add(java.util.ArrayList);

state_sets_test.get(0).add(1);
state_sets_test.get(0).add(3);
state_sets_test.get(0).add(4);
state_sets_test.get(0).add(5);
state_sets_test.get(0).add(6);
state_sets_test.get(0).add(8);

state_sets_test.get(1).add(2);
state_sets_test.get(1).add(7);
state_sets_test.get(1).add(9);
state_sets_test.get(1).add(10);
state_sets_test.get(1).add(11);
state_sets_test.get(1).add(12);
for i = 1:12
    state_sets_all.get(0).add(i);
%     Q_test(i,i) = 0;
end

n_large = 100;
Q_large = rand(n_large)*100;
for i = 1:n_large
    Q_large(i,i) = 0;
end
Q_large = Q_large - diag(sum(Q_large,2));

% Q_test = Q_test - diag(sum(Q_test,2));