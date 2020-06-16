%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: Lab_6_223.m
% Author: Karmyn VonEhr & Hannah Peters
% Date: 3/11/2020
% Instructor: Prof. Baine
% Description:  Generates theoretical and empirical plots of a random
% variable defined by a given equation(sqrt(2)*cos(theta)). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% PART 1 %%%%%%%%%
theta = -pi:1/100:pi;           
g = sqrt(2) .* cos(theta);          %given random variable

%Plot was used to find roots of the equation
figure;
plot(theta, g); grid; xlabel('Theta'); ylabel('g');
title("Roots");


%%%%%%%%% PART 2 %%%%%%%%%
x = -sqrt(2):1/100:sqrt(2);
fx = 1 ./ (sqrt(2).*pi.*sqrt(1 - ((x.^2)./ 2)));      %Derived PDF

%Plot of the derived PDF based on a uniform distribution of theta
figure;
plot(x, fx); grid; xlabel('x'); ylabel('fx');
title("Uniformy Distributed Theta");


%%%%%%%%% PART 3 %%%%%%%%%
theta = -pi + (2*pi).*rand(1,25000);   %uniformly dist. over given range
Nbins = 100; 
Max = pi; 
Min = -pi; 

X = sqrt(2).*cos(theta);               %Mapped uniform values to given R.V.

range = Min:(Max-Min)/Nbins:Max-((Max-Min)/Nbins);
histogram_vector = histogram_given(Min, Max, Nbins, X); 

[mean, variance] = sample_mu_var(X)    %outputs estimated mean and var

%Plot of empirical PDF
figure;
bar(range, histogram_vector); grid; xlabel('Range'); ylabel('Density');
title("PDF of New R.V.");
