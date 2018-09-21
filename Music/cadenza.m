s = audioread('fivesec.flac');
C = calcC(s);
C = C(1:10:end,:);

[M,R,P,N,Ps] = dynamicScore(C);
p = [5 8 10 16 20 25 32 40];

hold on
plot(s)
for i = N
    plot([10*i 10*i],[-0.03,0.03]) 
end
hold off


