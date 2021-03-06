function [val] = test_integrate(Q, state_sets, t0, t1, samples)
    
    Qs = ctmc_join(Q, state_sets);
    p = ctmc_stationary(Q);
    
    ns = size(Qs,1);

    function [ret] = calc(t)
        ret = zeros(1, length(t));
        for k = 1:length(t)
            P = expm(Q*t(k));
            Ps = expm(Qs*t(k));
            sum = 0;
            for seti_n = 1:ns
                seti = state_sets.get(seti_n-1);
                for setj_n = 1:ns
                    setj = state_sets.get(setj_n-1);
                    for is = 1:seti.size()
                        i = seti.get(is-1);

                        p_iB = 0;
                        for js = 1:setj.size()
                            j = setj.get(js-1);
                            p_iB = p_iB + P(i,j);
                        end

                        if p_iB ~= 0
                            sum = sum + p(i)*p_iB*log(p_iB / Ps(seti_n, setj_n));
%                             sum = sum + p(i)*Ps(seti_n, setj_n)*log(Ps(seti_n, setj_n) / p_iB);
                        end
                    end
                end
            end
            ret(k) = sum;
            
            if mod(k, 100) == 0
                disp(num2str(k));
            end
        end
    end

    t = linspace(t0, t1, samples);
    vals = calc(t);
    plot(t, vals);
    
    sum = 0;
    for i = 1:length(vals)-1
        sum = sum + (vals(i) + vals(i+1)) / 2;
    end
    
    val = sum;

%     val = integral(@calc,t0,t1);
end