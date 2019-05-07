th = 1;
mu = 0;
sig = 1;
dt = 1e-2;
t = 0:dt:10;             % Time vector
x0 = 0;                 % Set initial condition
 
ex = exp(-th*t);
X1 = x0*ex+mu*(1-ex)+sig*ex.*cumsum(exp(th*t).*[0 sqrt(dt)*randn(1,length(t)-1)]);
X2 = x0*ex+mu*(1-ex)+sig*ex.*cumsum(exp(th*t).*[0 sqrt(dt)*randn(1,length(t)-1)]);
 
tspan = t;
Xt = tspan;
 
ic = [0.5;0.5]; % Choose different initial conditions
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,r] = ode45(@(t,r) rderiv(t,r,Xt,X1,X2), tspan, ic, opts);
 
 
[t,g] = ode45(@(t,g) gderiv(t,g,Xt,X1,X2,r(:,1)), tspan, ic, opts);
 
 
%cuttof the shape at the first index in which |r'(t)| >= 1
rp = r(:,2);
 
index = 2;
while(norm(rp(1:index)) < 1)
   index = index + 1; 
end
rp = r(1:index, 1);
 
gt = g(1:index,1);
gp = diff(g(1:index,1));
gperp = g(1:index,2);
 
 
gp(length(gp)+1) = gp(length(gp));
 
rt = r(1:index,1);
 
 
Pp = gt + rt.*(-rp.*gp + sqrt(1 - rp.^2).*gperp);
Pn = gt + rt.*(-rp.*gp - sqrt(1 - rp.^2).*gperp);
 
t_s = t(1:index);
 
plot(t_s,Pp, t_s, Pn);
 
norm_rp = norm(r(:,2));