%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: PDF Estimation with Histograms
% Filename: EGR223_Lab4.m
% Author: Karmyn VonEhr
% Date: 2/12/2020
% Instructor: Prof. Baine
% Description:  File creates three histogram plots based on randomly
% generated input vectors. A histogram function is used to generate a
% vector of bin densities, with are then graphed with the range of bins. 
% The histograms are used to estimate the PDF of MATLAB pseudo-random noise
% generators. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% PLOT 1 GENERATION %%%%%%%%%%%

rng('shuffle');     %Used to generate a random stream each program run
Max = 2;
Min = -1;
Nbins = 100;
input = rand(1, 20000); %vector of 20000 uniformly dist. random numbers

HistogramVector = histogram(Max, Min, Nbins, input);

range = Min:(Max-Min)/Nbins:Max-((Max-Min)/Nbins);  %x-axis intervals

%histogram plot of rand()
figure;
bar(range, HistogramVector); grid; xlabel('Range'); ylabel('Density');
title("Histogram Plot 1");

%%%%%%%%%%% PLOT 2 GENERATION %%%%%%%%%%%
Max = 10;
Min = -10;
Nbins = 200;
input = randn(1, 50000); %vector of 50000 normally dist. random numbers

HistogramVector = histogram(Max, Min, Nbins, input);

range = Min:(Max-Min)/Nbins:Max-((Max-Min)/Nbins);

%histogram plot of randn()
figure;
bar(range, HistogramVector); grid; xlabel('Range'); ylabel('Density');
title("Histogram Plot 2");


%%%%%%%%%%% PLOT 3 GENERATION %%%%%%%%%%%
Max = 10;
Min = -10;
Nbins = 200;
input = (1:50000); %vector of 50000 summed unifomly dist. random numbers
for i = 1:50000
    input(i) = ((rand() + rand() + rand() + rand() + rand() + rand() + ...
        rand() + rand() + rand() + rand() + rand() + rand()) - 6);
end

HistogramVector = histogram(Max, Min, Nbins, input);

range = Min:(Max-Min)/Nbins:Max-((Max-Min)/Nbins);

%histogram plot of a sum of uniformly dist. numbers
figure;
bar(range, HistogramVector); grid; xlabel('Range'); ylabel('Density');
title("Histogram Plot 3");


