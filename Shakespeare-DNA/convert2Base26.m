function output = convert2Base26(vector,n)
%CONVERT2BASE26 Converts rolling window matrix to base 26 integer
vector = vector - 1;
x = zeros(n);
for i = 1:n
    x(i) = (26^(i-1));
end
output = vector*x';
end

