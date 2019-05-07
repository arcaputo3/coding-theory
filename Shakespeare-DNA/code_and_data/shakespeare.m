% SHAKESPEARE.M: Calculating the Probability of Letter Strings

% Code from Pattern Theory:
% Converts .txt to ascii
label = fopen('shakespeare.txt');
[hk,count] = fread(label,'uchar');
fclose(label);
F = double(hk);
F(F<33) = 27;
F(F>64 & F<91) = F(F>64 & F<91) - 64;
F(F>96 & F<123) = F(F>96 & F<123) - 96;
F = F(F<28);
F2 = [0;F(1:(size(F)-1))]+F;
G = F(F2<54);
% -------------------------------------

% RANDOM TEXT GENERATION -- WITH SPACE

% Convert strings to base 27 integers
G1space = G - 1;
G2space = createRollingWindow(G-1,2)*[1;27];
G3space = createRollingWindow(G-1,3)*[1;27;27^2];
G4space = createRollingWindow(G-1,4)*[1;27;27^2;27^3];

% Calculate Distributions and Entropies
[entropy1space,dist1space] = calcProb(G1space);
[entropy2space,dist2space] = calcProb(G2space);
[entropy3space,dist3space] = calcProb(G3space);
[entropy4space,dist4space] = calcProb(G4space);

% Create Hash Maps for each string and their associated probability
dict1space = createHashMap(dist1space,1,27);
dict2space = createHashMap(dist2space,2,27);
dict3space = createHashMap(dist3space,3,27);
dict4space = createHashMap(dist4space,4,27);

% Shannon's Game in order from P1 to P4
randomText1 = makeShakespeare(dict1space,1)
randomText2 = makeShakespeare(dict2space,2)
randomText3 = makeShakespeare(dict3space,3)
randomText4 = makeShakespeare(dict4space,4)

% MUTUAL INFORMATION -- NO SPACE

% Eliminate Space 

% Convert strings to base 26 integers
G1 = G - 1;
G2 = createRollingWindow(G-1,2)*[1;26];
G3 = createRollingWindow(G-1,3)*[1;26;26^2];
G4 = createRollingWindow(G-1,4)*[1;26;26^2;26^3];

% Calculate Distributions and Entropies
[entropy1,dist1] = calcProb(G1);
[entropy2,dist2] = calcProb(G2);
[entropy3,dist3] = calcProb(G3);
[entropy4,dist4] = calcProb(G4);

% Create Hash Maps for each string and their associated probability
dict1 = createHashMap(dist1,1,26);
dict2 = createHashMap(dist2,2,26);
dict3 = createHashMap(dist3,3,26);
dict4 = createHashMap(dist4,4,26);

G = G(G<27);

% Mutual Information of First 80 Characters
charArray(1:83) = upper(char(96+G(1+100:183)));

% Calculate mutual info for each consecutive pair
mi = zeros(80,1);
for i = 1:80    
    mi(i) = log2(dict4(charArray(i:i+3))/...
        (dict2(charArray(i:i+1))*dict2(charArray(i+2:i+3))));
end

% Code from Pattern Thoery
% CODE TO MAKE NICE OUTPUT
% PLOTTING ARRAY MI ABOVE ACTUAL CHARACTERS
hold off, plot(mi((1:80)));
axis([0 81 -20 20]); axis off, hold on
plot([0 81], [0 0]); plot([0 81], [4 4]);
text(0,0,'0 bits'); text(0, 4,'4 bits')
for i=3:83
    text(i-2+0.15,-2,lower(charArray(i)))
end

% Aggregate Entropies
allEntropies = [-log2(1/26) entropy1 entropy2 entropy3 entropy4;
    -log2(1/27) entropy1space entropy2space entropy3space entropy4space];
allEntropyRates = [-log2(1/26) entropy1 entropy2-entropy1 entropy3-entropy2 entropy4-entropy3;
    -log2(1/27) entropy1space entropy2space-entropy1space entropy3space-entropy2space entropy4space-entropy3space];


