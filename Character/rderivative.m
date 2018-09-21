function drdt = rderivative(r, C)
drdt = zeros(2*length(C), 1);
c_index = 1;
for i = 1:2:2*length(C)
    r1 = r(i);
    r2 = r(i+1);
    drdt(i) = r2;
    drdt(i+1) = (-C(c_index) * sqrt(1- r1) - r1^2 + 1) / r1;
    c_index = c_index + 1;
end
end

