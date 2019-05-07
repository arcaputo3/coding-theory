function dgdt = gderiv(t, g, Xt, X1, X2, r)
X1 = interp1(Xt, X1, t); % Interpolate the data set (Xt, X1) at times t
X2 = interp1(Xt, X2, t); % Interpolate the data set (Xt, X2) at times t
R = interp1(Xt, r, t);
 
dgdt = [g(2); (1/2*(exp(X1) - exp(X2)) ./ R).*g(2)];
end
