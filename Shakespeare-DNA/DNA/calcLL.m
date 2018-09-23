function LL = calcLL(M,prob)
%calcLL takes as input the matrix version of the DNA sequence and the
%probability of DNA codons to compute the likelihood for each subsequence.
%Additionally, we store the number of stops in LL column 2.

% Initiatialize LL
[rows,col] = size(M);
LL = zeros(rows,2);

for j = 1:rows
    % Count number of codons per sequence
    countDict = containers.Map(keys(prob),zeros(64,1));
    for i = 1:3:col-2
        countDict(M(j,i:i+2)) = countDict(M(j,i:i+2)) + 1;
    end
    % Calculate likelihood ratio per sequence
    for i = 1:3:col-2
        LL(j,1) = LL(j,1) + countDict(M(j,i:i+2))*log2(64*prob(M(j,i:i+2)));
    end
    % Determine number of stops per subsequence
    LL(j,2) = LL(j,2) + countDict('TAA') + countDict('TAG') + countDict('TGA');
end

