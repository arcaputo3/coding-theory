function [tranMatrix] = createTran(text)
%createTran generates the transition matrix of the sample text.

tranMatrix = zeros(27);

for i = 1:27
    textI = text(find(text(:,1) == i),:);
    M = tabulate(textI(:,2));
    tranMatrix(i,M(:,1)) = M(:,2)./sum(M(:,2));
end
