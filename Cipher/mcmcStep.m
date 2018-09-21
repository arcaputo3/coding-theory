function [LL,LLs,fnew] = mcmcStep(f,alpha,tranMatrix,text)
%MCMC takes as input the current guess f, scaling parameter alpha, the
%transition matrix, and the text.
%   Outputs either a new guess or stays at the current guess based on MCMC
%   protocol.

% Choose random indeces to flip
fs = f;
idx = randi(length(f),1,2);
fs(idx) = fs(flip(idx));

% Initialize current LL and new LLs
LL = 0;
LLs = 0;

% Compute LL and LLs 
for i = 1:size(text,1)
    LL = LL + log(1+tranMatrix(f(text(i,1)),f(text(i,2))));
    LLs = LLs + log(1+tranMatrix(fs(text(i,1)),fs(text(i,2))));
end

% Choose whether or not to transition
if LLs > LL
    fnew = fs;
elseif rand(1)<(LLs/LL)^alpha
    fnew = fs;
else
    fnew = f;
end
end
   