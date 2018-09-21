N = 2^15;
a = 10000;
b = 1;

pos_p = [5 8 10 16 20 25 32 40];
notes = poissonProcess(2^15,3000);
ss = zeros(2^15,1);

for i = 2:length(notes)
    p = randsample(pos_p,1,true,ones(length(pos_p),1));
    s = synthNotes(notes(i)-notes(i-1)+1,a,b,p);
    N = length(s);
    x = -(1-1/N):(2/N):1;
    f = (-1*x.^2+1)';
    
    s = f.*s;
    ss(notes(i-1):notes(i)) = s;

end
sound(ss)

