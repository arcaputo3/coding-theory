function drdt = rODE(t, r, Xt,C)
C = interp1(Xt, C, t); % Interpolate the data set (Xt, C) at times t
drdt = [r(2); (1-C*sqrt(1-r(2)^2)-r(2)^2)/r(1)]; % Evalute ODE at times t
end

%[t,g] = ode45(@(t,g) curveODE(t,g,K,Xt), tspan, ic, opts);