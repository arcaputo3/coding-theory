function drdt = kODE(t, r, Xt, X1, X2)
X1 = interp1(Xt, X1, t); % Interpolate the data set (ft, f) at times t
X2 = interp1(Xt, X2, t); % Interpolate the data set (gt, g) at times t
drdt = [r(2); (((exp(X1)+exp(X2))/2)*sqrt(1-r(2)^2)+r(2)^2-1)/(-r(1))]; % Evalute ODE at times t
end