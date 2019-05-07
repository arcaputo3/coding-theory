function [x] = sample_o_h(th,mu,sig,dt,T)
%SAMPLE_O_H samples an Ornstein-Uhlenbeck Process with given params
t = 0:dt:T;             % Time vector
x = zeros(1,length(t)); % Allocate output vector, set initial condition
%rng(1);                 % Set random seed
for i = 1:length(t)-1
    x(i+1) = x(i)+th*(mu-x(i))*dt+sig*sqrt(dt)*randn;
end
 
end



