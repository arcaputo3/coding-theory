function output = decodeChar_(number,n,B)
%DECODE Converts base B encoding to string of letters of length n

% Initialize x and output
x = zeros(n,1)';
output = char(zeros(n,1)');
x(1) = mod(number,B);
output(1) = char('A'+x(1));

if n>1
    for i = 2:n
        % Computes the Base B decoded string
        x(i) = mod(number - x(1:i-1)*(B.^(0:i-2))',B^i)/B^(i-1);
        % Converts to char
        output(i) = char('A'+x(i));
    end
end

% Converts '[' to space via char decoding
output = strrep(char(output),'[',' ');
end