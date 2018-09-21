function output = decodeChar(number,n)
%DECODE Converts base 26 encoding to string of letters of length n

if n == 2
    x(1) = rem(number,26);
    x(2) = (number-x(1))/26;
    output = [char('A'+x(1)) char('A'+x(2))];
elseif n == 3
    x(1) = rem(number,26);
    x(2) = mod(number - x(1),26^2)/26;
    x(3) = (number - x(1) - x(2)*26)/26^2;
    output = [char('A'+x(1)) char('A'+x(2)) char('A'+x(3))];
elseif n == 4
    x(1) = rem(number,26);
    x(2) = mod(number - x(1),26^2)/26;
    x(3) = mod(number - x(1)- x(2)*26,26^3)/26^2;
    x(4) = (number - x(1) - x(2)*26 - x(3)*(26^2))/26^3;
    output = [char('A'+x(1)) char('A'+x(2)) char('A'+x(3)) char('A'+x(4))];
else
    output = char('A'+number);
end
% If using space, next line converts to space based on char operation
output = strrep(char(output),'[',' ');
end

