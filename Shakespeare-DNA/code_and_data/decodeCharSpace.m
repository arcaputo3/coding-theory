function output = decodeCharSpace(number,n)
%DECODE Converts base 27 encoding to string of letters of length n

if n == 2
    x(1) = rem(number,27);
    x(2) = (number-x(1))/27;
    output = [char('A'+x(1)) char('A'+x(2))];
elseif n == 3
    x(1) = rem(number,27);
    x(2) = mod(number - x(1),27^2)/27;
    x(3) = (number - x(1) - x(2)*27)/27^2;
    output = [char('A'+x(1)) char('A'+x(2)) char('A'+x(3))];
elseif n == 4
    x(1) = rem(number,27);
    x(2) = mod(number - x(1),27^2)/27;
    x(3) = mod(number - x(1)- x(2)*27,27^3)/27^2;
    x(4) = (number - x(1) - x(2)*27 - x(3)*(27^2))/27^3;
    output = [char('A'+x(1)) char('A'+x(2)) char('A'+x(3)) char('A'+x(4))];
else
    output = char('A'+number);
end
% If using space, next line converts to space based on char operation
output = strrep(char(output),'[',' ');
end
