% Code from Pattern Theory:
% Converts .txt to ascii
label = fopen('DNA.txt');
[hk,count] = fread(label,'uchar');
fclose(label);
F = double(hk);
F(F<33) = 27;
F(F>64 & F<91) = F(F>64 & F<91) - 64;
F(F>96 & F<123) = F(F>96 & F<123) - 96;
F = F(F<28);
F2 = [0;F(1:(size(F)-1))]+F;
G = F(F2<54);
G = G(G<27);
G = upper(char(G + 96));

%M_k is the sequence G sorted by subsequences of length 120 starting at
%index k

M0 = createRollingWindow(G);

M1 = createRollingWindow(G(2:end));

M2 = createRollingWindow(G(3:end));

% Convert DNA sequence probability to table
table = readtable('DNAfrequency.csv');
table.Properties.VariableNames{1} = 'Triplet';
codons = table.Triplet;
prob = table.Probability;

% Initiate probability hash map 
probDict = containers.Map;

% Key: Codon, Value: Probability 
for i = 1:64
    probDict(replace(cell2mat(codons(i)),'U','T')) = prob(i);
end

% Calculate LL(3a), LL(3a+1), LL(3a+2)
LL0 = calcLL(M0,probDict);
LL1 = calcLL(M1,probDict);
LL2 = calcLL(M2,probDict);

% Create Plots for each Likelihood:
% Line plot represents likelihood
% Bar plot represents number of stops
ax1 = subplot(3,1,1);
yyaxis right
ylabel('Likelihood')
p1 = plot(ax1,LL0(:,1));
p1.LineWidth = 3;
yyaxis left
b1 = bar(LL0(:,2));
title('LL(3a)')

ax2 = subplot(3,1,2);
yyaxis right
p2 = plot(ax2,LL1(:,1));
p2.LineWidth = 3;
yyaxis left
b2 = bar(LL1(:,2));
title('LL(3a+1)')

ax3 = subplot(3,1,3);
yyaxis right
p3 = plot(ax3,LL2(:,1));
p3.LineWidth = 3;
yyaxis left
b3 = bar(LL2(:,2));
title('LL(3a+2)')


