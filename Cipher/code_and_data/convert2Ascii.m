function [output] = convert2Ascii(text)
%CONVERT2ASCII converts a .txt file to ascii, removing punctuation and
%capitalization, labelling a,...,z,' ' as 1-27.
label = fopen(text);
[hk,count] = fread(label,'uchar');
fclose(label);
F = double(hk);
F(F<33) = 27;
F(F>64 & F<91) = F(F>64 & F<91) - 64;
F(F>96 & F<123) = F(F>96 & F<123) - 96;
F = F(F<28);
F2 = [0;F(1:(size(F)-1))]+F;
output = F(F2<54);
end

