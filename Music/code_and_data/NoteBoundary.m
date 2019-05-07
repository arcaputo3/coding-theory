function [ns,min_ps] = NoteBoundary(C,a)
%NoteBoundary takes as input the lookup table C and calculates the most
%likely score

prev_b = 1;
n = length(C);
e = zeros(1,n);
min_ps = zeros(1,n);
ps = [5 8 10 16 20 25 32 40];
ns = [0]; % Stores note boundaries
n_idx = 2;

current_p = 0;

for t = 2:n
    min = 99999999;
    min_prev_t = 0;
    min_p = 0;
    for prev_t = prev_b:(t-1)
        for p = ps
            nn = 0; % New Note indicator 
            if (p ~= current_p)
                nn = 1;
            end
            % Energy Function
            E = e(prev_t) - 2*(C(t,p)-C(prev_t,p)) + a*nn;
            if (E < min)
                min_prev_t = prev_t;
                min_p = p;
                min = E;
            end
        end
    end
    e(t) = min;
    min_ps(t) = min_p;
    current_p = min_p;
    
    % If min t' not equal to prev t', found new boundary
    if (min_prev_t ~= prev_b)
        prev_b = min_prev_t;
        new_note = 1;
        ns(n_idx) = prev_b;
        n_idx = n_idx+1;
    else
        new_note = 0;
    end
end
        
    
