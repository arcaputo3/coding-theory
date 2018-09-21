function output = makeShakespeare(dict,n)
%Samples 200 characters from Shakespeare initial P4 distribution and
%continues using P4(d|abc)

% Extract String, Probability arrays
strList = string(keys(dict));
initialProb = cell2mat(values(dict));

% Sample from initial P4 probability distribution
init = strList(find(rand<cumsum(initialProb),1,'first'));
output = init;

for i = 1:200
    % Gather last three letters
    reader = char(output);
    reader = reader(end-(n-2):end);
    
    % Sample from conditional P4 distribution
    [newProb,newStrList] = condProb(dict,reader);
    newStr = newStrList(find(rand<cumsum(newProb),1,'first'));
    
    % Gather last letter
    newStr = char(newStr);
    newLetter = newStr(end);
    
    % Append letter to output
    output = output + string(newLetter);
end
end

