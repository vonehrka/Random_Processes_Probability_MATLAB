
function prob = bern(k, N, p)       %function accepts, K, N, and p  
q = 1 - p;                          %depending on the part 
m = N - k;                          %q and m are calculated

    if((k>=0) && (N>0) && (k<=N))   %must satisfy these conditions
        prob = (factorial(N)/(factorial(k)*factorial(m)))*(p^k)*(q^m);
    else
        fprintf('ERROR')
    end
end