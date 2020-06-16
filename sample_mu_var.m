
function [mean, variance] = sample_mu_var(input_vector)

if(isvector(input_vector))
    N = length(input_vector); 
    S = sum(input_vector); 
    mean = S / N; 
    variance = sum((input_vector - mean).^2) / (N-1); 
end 

end


