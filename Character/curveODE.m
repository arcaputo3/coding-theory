function dgdt = curveODE(t,g,K,Xt)
K = interp1(Xt, K, t); % Interpolate the data set (Xt, K) at times t
dgdt = [g(2); K*(g(2))]; % Evalute ODE at times t
end