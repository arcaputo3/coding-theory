function [tranMatrix] = createQ(Z)
%createQ generates the transition matrix of the sample distribution.

Y = createRollingWindow(Z,2);
tranMatrix = zeros(3);

for i = 1:3
    I = Y(Y(:,1) == i,:);
    M = tabulate(I(:,2));
    tranMatrix(i,:) = M(:,3)./100;
end
