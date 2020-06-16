%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Total Probability Theorem
% Filename: EGR223_Lab3.m
% Author: Karmyn VonEhr
% Date: 2/3/2020
% Instructor: Prof. Baine
% Description:  Performs multiple trials of each function created. Presents
% emperical and theoretical answers to the problems provided. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = 0.52;           %Probability of A striking the target
B = 0.48;           %Probability of B striking the target
C = 0.375;          %Probability of C striking the target

H1 = 0.25;          %Probability of being hit by a single missile
H2 = 0.49;          %Probability of being hit by two missiles
H3 = 0.88;          %Probability of being hit by three missiles

M1 = 0.33;          %Probability relay is from manufacturer 1
M2 = 0.42;          %Probability relay is from manufacturer 2
M3 = 0.25;          %Probability relay is from manufacturer 3

D1 = 0.01;          %Probability relay from manufactuere 1 is defective
D2 = 0.005;         %Probability relay from manufactuere 2 is defective
D3 = 0.03;          %Probability relay from manufactuere 3 is defective

L = 50000;           %Number of trials
k = 0;              %Initialize incrementing variables
K = 0;
T = 0;
M = 0;
N = 0;

rng('shuffle');     %Used to generate a random stream each program run

for i = 1:L
    [Ahit, Bhit, Chit, SinkSankSunk, sum] = missile(A,B,C,H1,H2,H3);
    if(SinkSankSunk == 1)
        k = k + 1;
        
        if(Bhit == 1)    %Count number of times B hit,
            T = T + 1;   %knowing target was hit
        end
        
        if(sum == 1)     %Count number of times only one hit,
            K = K + 1;   %knowing target was hit
        end
    end

    [Man1, Man2, Man3, Defective] = relay(M1, M2, M3, D1, D2, D3);
    if(Defective == 1)
        M = M + 1;
        
        if(Man3 == 1)   %Count number of times manufacturer 3 was selected,
            N = N + 1;  %knowing it was defective
        end
    end
    
end

%Calculations of the Emperical results and hard coded theoretical results
Empirical_1a = k / L;
Theoretical_1a = (H1 * 0.4066) + (H2 * 0.3438) + (H3 * 0.0936);

Empirical_1b = K / k;
Theoretical_1b = (H1 * 0.4066) / Theoretical_1a;

Empirical_1c = T / k;
Theoretical_1c = (B * 0.49405) / Theoretical_1a;

Empirical_2a = M / L;
Theoretical_2a = (D1 * M1) + (D2 * M2) + (D3 * M3);

Empirical_2b = N / M;
Theoretical_2b = (D3 * M3) / Theoretical_2a;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Use the perctdiff() function to find the percent difference of each part
percent1a = perctdiff(Theoretical_1a, Empirical_1a);
percent1b = perctdiff(Theoretical_1b, Empirical_1b);
percent1c = perctdiff(Theoretical_1c, Empirical_1c);
percent2a = perctdiff(Theoretical_2a, Empirical_2a);
percent2b = perctdiff(Theoretical_2b, Empirical_2b);

%Print the results from part 1A
fprintf('\nPart 1A: Probability that the target is destroyed.')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_1a, Empirical_1a, percent1a)

%Print the results from part 1B
fprintf('\n\nPart 1B: Probability target is destroyed by a single missile.')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_1b, Empirical_1b, percent1b)

%Print the results from part 1C
fprintf('\n\nPart 1C: Probability target is destroyed by missile B.')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_1c, Empirical_1c, percent1c)

%Print the results from part 2A
fprintf('\n\nPart 2A: If relay is selected randomly, what is the probabilty it is defective?')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_2a, Empirical_2a, percent2a)

%Print the results from part 2B
fprintf('\n\nPart 2B: If relay is found to be defective, what is the probability it was manufactured at plant 3?')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%\n\n\n'...
    , Theoretical_2b, Empirical_2b, percent2b)



