x1 = sample_o_h();
x2 = sample_o_h();
 
 
C = 1/2*(exp(x1) + exp(x2));
Z = 1/2*(exp(x1) - exp(x2));
 
dt = 1e-2;
t = 0:dt:2;
 
tspan = [0 2];
r0 = 0.9*ones(2*length(C), 1);
 
sol = ode45(@(t,r) rderivative(r,C) ,tspan,r0, C);
 
r = deval(sol,t);
 
