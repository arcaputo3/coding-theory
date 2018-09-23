function output = createRollingWindow(vector)
% CREATEROLLINGWINDOW modified for DNA problem
% Each row is every possible sequence of length 120

output = char(zeros(600,120));
for a = 0:627
    output(a+1,1:120) = vector(3*a+1:3*a+120);
end