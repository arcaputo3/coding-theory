function dict = createHashMap(dist,n,B)
%CREATEHASHMAP Takes as input a distribution, the dimension n, and the base B, and
%outputs a hash map with n-length strings and their associated probability

% Initialize Hash Map
dict = containers.Map;

for i = 1:size(dist,1)
    % Set each key as decoded n-strings
    %     each value as associated probability
    dict(decodeChar_(dist(i,1),n,B)) = dist(i,3)/100;
end
end
