% Code from  Pattern Theory:
% Converts .txt to ascii

% Upload Training Data: Lord of the Rings 1-3
G = convert2Ascii('WAP.txt');
G2 = createRollingWindow(G,2);
% Compute Transition Matrix M
M = createTran(G2);

% Upload Cipher
C = convert2Ascii('scram2G.txt');
C2 = createRollingWindow(C,2);


% Initialize Params
iter = 15000;
LL = zeros(iter,1);
LLs = zeros(iter,1);
f = zeros(iter+1,27);

% Start with 1-to-1
f(1,:) = 1:27;
% Good guess swapping for correct space
%f(1,[9 27]) = f(1,[27 9]);

% Better guess using entire prob dist
pC = tabulate(C);
pG = tabulate(G);

[a_sorted, a_order] = sort(pC);
pC = pC(a_order);

[b_sorted, b_order] = sort(pG);
pG = pG(b_order);

pC = fliplr(pC(:,3)');
pG = fliplr(pG(:,3)');

for i = 1:27
    f(1,probIdx(1,i)) = probIdx(2,i);
end
probIdx = [pC;pG];

% Iterate
for k = 1:iter
    [LL(k),LLs(k),f(k+1,:)] = mcmcStep(f(k,:),300,M,C2);
    % Print max so far every 500 steps
    if mod(k,500) == 0
        [~,ind] = max(LL);
        fm = f(ind+1,:);
        D = fm(C(1:100));
        decode = strrep(char(D + 96),'{',' ')
    end
end

% Plot likelihood
plot(LL)
[~,ind] = max(LL);
fm = f(ind+1,:);
D = fm(C);
decode = strrep(char(D + 96),'{',' ')
