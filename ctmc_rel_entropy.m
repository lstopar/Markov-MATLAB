function [val] = ctmc_rel_entropy(Q, state_sets)
    
    
    
    Qs = ctmc_join(Q, state_sets);

%     n = size(Q,1);
    ns = size(Qs,1);
    p = ctmc_stationary(Q);
    
    sum1 = 0;
    sum2 = 0;
    
    % works
    for seti_n = 1:ns
        seti = state_sets.get(seti_n-1);
        
        for is = 1:seti.size()
            i = seti.get(is-1);
            for setj_n = 1:ns
                setj = state_sets.get(setj_n-1);

                for js = 1:setj.size()
                    j = setj.get(js-1);
                    if Q(i,j) ~= 0 && j ~= i
                        sum1 = sum1 + p(i)*Q(i,j)*log(Q(i,i)/Qs(seti_n,seti_n));
                    end
                end
            end
            
            sum2 = sum2 + p(i)*(Q(i,i) - Qs(seti_n,seti_n));
        end
    end

    val = sum1 + sum2;
    
%     for seti_n = 1:ns
%         seti = state_sets.get(seti_n-1);
%         for setj_n = 1:ns
%             setj = state_sets.get(setj_n-1);
%             for is = 1:seti.size()
%                 i = seti.get(is-1);
%                 
%                 q_iB = 0;
%                 for js = 1:setj.size()
%                     j = setj.get(js-1);
%                     q_iB = q_iB + Q(i,j);
%                 end
%                 
%                 q_AA = 0;
%                 for js = 1:seti.size()
%                     j = seti.get(js-1);
% 
%                     q_AA = q_AA + p(i)*Q(i,j);
%                 end
%                 
%                 if seti_n ~= setj_n && q_AA ~= 0
%                     sum1 = sum1 + p(i)*q_iB*log(Q(i,i) / Qs(seti_n, seti_n));
%                 end
%             end
%         end
%         
%         q_AA = 0;
%         for is = 1:seti.size()
%             i = seti.get(is-1);
%             for js = 1:seti.size()
%                 j = seti.get(js-1);
%                 
%                 q_AA = q_AA + p(i)*Q(i,j);
%             end
%         end
%         
%         sum2 = sum2 + q_AA - Qs(seti_n,seti_n);
%     end
%     
%     val = sum1 + sum2;
end