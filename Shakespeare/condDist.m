function output = condDist(prob,smallProb)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

letters = {'A','B','C','D','E','F','G','H','I','J','K','L','M',...
    'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' '};
init = zeros(27,1);
outputProb = containers.Map(letters,init);

allLetters = string(keys(smallProb));
str = string(keys(prob));

for k = 1:size(allLetters,2)
strList = str(endsWith(str,allLetters(k)));
    for i = 1:size(strList,2)
        letter = char(strList(i));
        outputProb(letter(end)) = outputProb(letter(end))+ prob(letter)/smallProb(letter(1:end-1));
    end
end
dist = cell2mat(values(outputProb));
output = -dist*log2(dist)';
end
%{
str = string(keys(prob));

letters = cell2mat(letters);
for i = 1:size(letters,2)
    strList = str(startsWith(str,char(letters(i))));
    allProb = zeros(size(strList,2),1);
    for j = 1:size(strList,2)
        outputProb(char(letters(i))) = con
    end
    outputProb(char(letters(i))) = sum(allProb)/singleProb(char(letters(i)));
end
dist = cell2mat(values(outputProb));
entropy = -dist*log2(dist)';
end
%}