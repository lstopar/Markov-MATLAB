%%
t = 0:2:10000;

y = zeros(size(t));
ys = zeros(size(t));
diff = zeros(size(t));
s = 0;

for i = 1:length(t)
    P = expm(Q*t(i));
    Ps = expm(Qs*t(i));
    y(i) = sum(P(6,6:7));
    ys(i) = Ps(3,3);
    diff(i) = y(i) - ys(i);
    s = s + diff(i);
    
    if mod(i, 1000) == 0
        i
    end
end

% plot(t, y, t, ys);
plot(t, diff);
s
