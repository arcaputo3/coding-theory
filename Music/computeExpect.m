function [P,T,S,c,y1,y11] = computeExpect(x,lc,l0,l1,BA)
%COMPUTEEXPECT calculates expectations at every step of the EM algorithm

N = length(x);

c = 0;
y1 = 0;
y11 = 0;

T = zeros(N,2);
S = zeros(N,1);
P = zeros(N,2);

a = @(y2,y1) lc*(y2 == y1) + (1-lc)*(y2 ~= y1); 
f = @(x,y) x.*BA.*(l1.*y + l0.*(1-y)) + (1-x).*((1-l1.*BA).*y+(1-l0.*BA).*(1-y));

Temp = a([0 1],0).*f(x(1),0) + a([0 1],1).*f(x(1),1);
S(1) = sum(Temp);
T(1,:) = Temp/S(1);

% Forward computation
for i = 2:N-1
    %Compute T for each i
    Temp = T(i-1,1)*a([0 1],0)*f(x(i),0) + T(i-1,2)*a([0 1],1)*f(x(i),1);
    S(i) = sum(Temp);
    T(i,:) = Temp/S(i,:);
end
S(N) = T(N-1,1)*f(x(N),0)+T(N-1,2)*f(x(N),1);

% Backward computation:
P(N,:) = f(x(N),[0 1]).*T(N-1,:)/S(N);
y1 = y1 + P(N,2);
y11 = y11 + (x(N) == 1)*P(N,2);
for i = fliplr(2:N-1)
    P(i,:) = (P(i+1,1).*a(0,[0 1])+P(i+1,2).*a(1,[0 1])).*f(x(i),[0 1]).*T(i-1,:)./sum(P(i+1,:).*T(i,:).*S(i));
    c = c + P(i,1)*P(i+1,1) + P(i,2)*P(i+1,2);
    y1 = y1 + P(i,2);
    y11 = y11 + (x(i) == 1)*P(i,2);
end

P(1,:) = (P(2,1).*a(0,[0 1])+P(2,2).*a(1,[0 1])).*f(x(1),[0 1])/sum(P(2,:).*T(1,:)*S(1));

c = c + P(1,1)*P(2,1) + P(1,2)*P(2,2);
y1 = y1 + P(1,2);
y11 = y11 + (x(i) == 1)*P(1,2);
end
