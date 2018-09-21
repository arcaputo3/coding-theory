function [C] = calcC(s)
% Takes as input an audio file and outputs the lookup table c
N = length(s)-40;
p = [5 8 10 16 20 25 32 40];
C = zeros(N,40);

for j = p
    C(1,p) = s(1)*s(1+j);
end

for j = p
    for i = 2:N
        C(i,j) = C(i-1,j) + s(i)*s(i+j);
    end
end

