function dict = createHashMapSpace(dist,n)
%CREATEHASHMAP Takes as input a distribution and the dimension n and
%outputs a hash map with n-length strings and their associated probability

dict = containers.Map;
for i = 1:size(dist,1)
    dict(decodeCharSpace(dist(i,1),n)) = dist(i,3)/100;
end
end