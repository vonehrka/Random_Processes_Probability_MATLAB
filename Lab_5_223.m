
lambda = 30; 
uni_vector = rand(1,20000); 
Nbins = 1000; 
Max = 2; 
Min = 0; 

exp_vector = map_exponential(uni_vector, lambda); 

histogram_vector = histogram_given(Min, Max, Nbins, exp_vector); 

range = Min:(Max-Min)/Nbins:Max-((Max-Min)/Nbins);

[mean, variance] = sample_mu_var(exp_vector)

figure;
bar(range, histogram_vector); grid; xlabel('Range'); ylabel('Density');
title("PDF of New R.V.");

