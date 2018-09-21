function [Q] = runsEM(x,lc,l0,l1,iter,BA)
%RUNSEM calculates the best possible lambda for iter number of steps

% Init
N = length(x);
Q = zeros(iter,3);
Q(1,:) = [lc l0 l1];

% Steps
for k = 2:iter
    [~,~,~,c,y1,y11] = computeExpect(x,Q(k-1,1),Q(k-1,2),Q(k-1,3),BA);
    Q(k,1) = c/(N-1); 
    Q(k,2) = (sum(x)-y11)/(BA*(N-y1));
    Q(k,3) = y11/(BA*y1);
end
end
