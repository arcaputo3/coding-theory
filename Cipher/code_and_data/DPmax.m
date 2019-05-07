% Upload Training Data: Lord of the Rings 1-3
G = convert2Ascii('WAP.txt');
G2 = createRollingWindow(G,2);
% Compute Transition Matrix M
M = createTran(G2);
M = M';
f = 1:27;

% Upload Cipher
C = convert2Ascii('scram2G.txt');
text = createRollingWindow(C,2);
len = size(text,1);

pC = tabulate(C);
pG = tabulate(G);

[a_sorted, a_order] = sort(pC);
pC = pC(a_order);
pC = fliplr(pC(:,3)');

[b_sorted, b_order] = sort(pG);
pG = pG(b_order);
pG = fliplr(pG(:,3)');

probIdx = [pC;pG];
f = zeros(27,1)';

for i = 1:27
    f(probIdx(1,i)) = probIdx(2,i);
end

L = zeros(len,27);
R = zeros(len,27);

for j = 1:27
    LL = 0;
    for i = 1:len
        LL = LL + log(1+M(f(text(i,1)),f(text(i,2))));
        [L(i,j),R(i,j)] = max(log(1+M(f(text(i,1)),f(text(i,2)))));
    end
end

D = f(C);
decode = strrep(char(D + 96),'{',' ')

