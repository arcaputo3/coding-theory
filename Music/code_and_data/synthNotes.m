function [s] = synthNotes(N,a,b,p)
%SYNTHNOTES

x = randn(N,1);
y = randn(N,1);

for k = 1:N
    x(k) = x(k)*(1/(b + 4*a*sin(pi*p*k/N)^2));
    y(k) = y(k)*(1/(b + 4*a*sin(pi*p*k/N)^2));
end

s = real((1/sqrt(N))*fft(x+1i*y));


