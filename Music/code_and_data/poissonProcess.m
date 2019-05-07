function [notes] = poissonProcess(n,lambda)
%POISSONPROCESS creates takes as input a total length n, an expected length
%lambda, and outputs note boundaries

notes = zeros(n,1);
t0 = lambda; 
t = -log(rand(1,n))*t0;
notes(1) = 1;
for i = 2:n-1
    if rand(1) > t(i)
        notes(i) = 1;
    else
        notes(i) = 0;
    end
end

notes(n) = 1;
notes = find(notes == 1);