function [entropy,distribution] = calcProb(vector)
% CALCPROB returns the tabulated distribution and entropy of the
% distributuion 

% Tabulate -  COL1  -   COL2     -    COL3     -
%          - Number - Occurences - Probability -  
distribution = tabulate(vector);

% Eliminates 0log0
distribution = distribution(distribution(:,2) > 0,:);

% Convert probability distribution from percentage to [0,1]
dist = distribution(:,3)/100;

% Calculate entropy
entropy = -dist' * log2(dist);

end


