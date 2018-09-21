function [s] = synthColNoise(N,l)
%SYNTHCOLNOISE synthesizes color noise for a power parameter l

x = randn(N,1);
y = randn(N,1);

x(1) = 0;
y(1) = 0;
for k = 2:N-1
    x(k) = x(k)*(1/min(k,N-k)^l);
    y(k) = y(k)*(1/min(k,N-k)^l);
end
s = real(ifft(x+1i*y));

plot(s)

