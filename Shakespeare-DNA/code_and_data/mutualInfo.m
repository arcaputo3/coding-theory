function mi = mutualInfo(textArray,P2,P4)
%MUTUALINFO Calculates the Mutual Information of the first 83 characters of
%a (non-space) text array in ascii format (1-26)
%   Prints Graph with mutual information above each letter (Code from
%   Textbook)

% Decode text array into char format
charArray(1:83) = char(96+textArray(1:83));

% Calculate mutual info for each consecutive pair
mi = zeros(80,1);
for i = 1:80    
    mi(i) = P4(charArray(i:i+3))/(P2(charArray(i:i+1))*P2(charArray(i+2:i+3)));
end

% CODE TO MAKE NICE OUTPUT
% PLOTTING ARRAY MI ABOVE ACTUAL CHARACTERS
hold off, plot(mi((1:80)));
axis([2 83 -20 20]); axis off, hold on
plot([0 81], [0 0]); plot([0 81], [4 4]);
text(0,0,'0 bits'); text(0, 4,'4 bits')
for i=1:80
    text(i+0.15,-2,char(96+textArray(i)))    
end
end