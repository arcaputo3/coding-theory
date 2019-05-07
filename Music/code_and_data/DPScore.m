function [M,R,P,N,Ps] = DPScore(C)
%DYNAMICSCORE takes as input the lookup table C and calculates the most
%likely score
K = 10;
L = length(C);
%K = ceil(exprnd(1/a));
M = zeros(L,8);
R = ones(L,8);
P = zeros(L,8);
N = zeros(K,1);
Ps = zeros(K,1);

p = [5 8 10 16 20 25 32 40];

for n = 2:L
    for j = 1:8
        [TM,TR] = max(C(n,p(j)) - C(1:n-1,p(j)) + M(1:n-1,:));
        [M(n,j),ind] = max(TM);
        R(n,j) = TR(ind);
        P(n,j) = ind;
    end
end

[~,ind] = max(M(4000,:));
N(K) = 4000;
Ps(K) = ind;

for k = fliplr(2:K-1)
    N(k) = R(N(k+1),Ps(k+1));
    Ps(k) = P(N(k+1),Ps(k+1));
end

N(1) = 1;
Ps(1) = P(N(2),Ps(2),1);