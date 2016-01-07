%%
heightV(end) = inf;
for i = 1:size(Q_test,1)
    id = i;
%     disp(['state: ',num2str(id)]);
%     disp(heightV(id));
    while true
        if heightV(id) > heightV(hierarchV(id))
            disp(['Parent lower, id: ',num2str(i)]);
        end

        id = hierarchV(id);
        disp(heightV(id));
        if id == hierarchV(id)
            break;
        end
    end
end
disp('Done!');