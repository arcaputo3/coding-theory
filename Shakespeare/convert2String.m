function [output] = convert2String(vector,alphabet)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,m] = size(vector);
output = zeros(n,1);
for i = 1:n
    ind = "";
    for j = 1:m
        ind = ind + string(alphabet(vector(i,j)));
    end
    output(i) = ind;
end
end
