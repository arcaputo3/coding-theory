function [M,R,P,N,Ps] = dynamicScore(C)
%DYNAMICSCORE takes as input the lookup table C and calculates the most
%likely score
K = 8;
L = length(C);
%K = ceil(exprnd(1/a));
M = zeros(L,8,K-1);
R = ones(L,8,K-1);
P = zeros(L,8,K-1);
N = zeros(K,1);
Ps = zeros(K,1);
T = length(C);

p = [5 8 10 16 20 25 32 40];

for n = 5:L
    for j = 1:8
        h = C(n,p(j)) - C(1:n-4,p(j)) + C(1:n-4,p) - C(1,p);
        [M(n,j,1),idx] = max(h(:));
        [R(n,j,1),P(n,j,1)] = ind2sub(size(h),idx);
    end
end

for k = 2:K-2
    for n = 5:L
        for j = 1:8
            h = (C(n,p(j)) - C(1:n-4,p(j)))+M(1:n-4,:,k-1);
            [M(n,j,k),idx] = max(h(:));
            [R(n,j,k),P(n,j,k)] = ind2sub(size(h),idx);
        end
    end
end


for j = 1:8
    h = C(T,p(j)) - C(1:T-4,p(j)) + M(1:T-4,:,K-2);
    [M(T,j,K-1),idx] = max(h(:));
    [R(T,j,K-1),P(T,j,K-1)] = ind2sub(size(h),idx);
end

[~,ind] = max(M(T,:,K-1));
N(K) = T;
Ps(K) = ind;

for k = fliplr(2:K-1)
    N(k) = R(N(k+1),Ps(k+1),k);
    Ps(k) = P(N(k+1),Ps(k+1),k);
end

Ps(1) = P(N(2),Ps(2),k);
N(1) = 1;