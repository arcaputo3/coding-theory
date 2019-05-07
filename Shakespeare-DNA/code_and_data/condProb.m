function [output,strList] = condProb(dict,sample)
%CONDPROB is used to sample from P(letter|sample)

% Initialize list of all possible keys
str = string(keys(dict));

% Keep only those that start with sample
strList = str(startsWith(str,sample));

% Initialize probability vector
prob = zeros(size(strList,2));

for i = 1:size(strList,2)
    % Gather each probability from strList
    prob(i) = dict(char(strList(i)));
end

% Normalize for conditional probability
output = prob/sum(prob);
end

