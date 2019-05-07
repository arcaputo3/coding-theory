% Set initial Params
th = 10;
mu = 5;
sig = 10;
dt = 0.01;
T = 5;
Xt = 0:dt:T;

% Sample OH process
X1 = sample_o_h(th,mu,sig,dt,T);
X2 = sample_o_h(th,mu,sig,dt,T);

% Values necessary
C = 1/2*(exp(X1) + exp(X2));
Z = 1/2*(exp(X1) - exp(X2));

% Tspan and initial conditions for r
tspan = [0 T];
ic = [0.5;-0.2];
[~,r] = ode45(@(t,r) rODE(t,r,Xt,C), tspan, ic);

% Find where r stopped
m = length(r);
% Use new time discretization
dt2 = T/m;

% Find time where |r'(t)| < 1 
% Same as where r'(t) becomes imaginary
n = sum(imag(r(:,2)) == 0);
r = r(1:n,:);
K = Z(1:n)./r(:,1)';

% Solve for gamma with new time discretization
Xt2 = 0:dt2:((n-1)*dt2);
tspan2 = [0 (n-1)*dt2];
ic2 = [0;-1];
[t,g] = ode45(@(t,g) curveODE(t,g,K,Xt2), tspan2, ic2);

% Use shortest length
if length(g) > length(r)
    n = length(r);
else
    n = length(g);
end

% Get each gamma
gt = g(1:n,1);
gp = diff(g(1:n,1));
gperp = g(1:n,2);
gp(length(gp)+1) = gp(length(gp));

% Get each r
rt = r(1:n,1);
rp = r(1:n,2);

% Solve for P and plot
Pp = gt + rt.*(-rp.*gp + sqrt(1 - rp.^2).*gperp);
Pn = gt + rt.*(-rp.*gp - sqrt(1 - rp.^2).*gperp);

% Get t
t_s = t(1:n);
 
plot(t_s,Pp, t_s, Pn);

