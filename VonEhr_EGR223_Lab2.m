%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: MATLAB Functions and Bernoulli Trials
% Filename: VonEhr_EGR223_Lab2.m
% Author: Karmyn VonEhr
% Date: 1/22/2020
% Instructor: Prof. Baine
% Description:  Use of functions to learn Bernoulli trials
%               and to compare theoretical and experimental results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S = 6;              %Number of sides
L = 100000;         %Number of trials

ka = 5;             %Desired number of successes in part a
Na = 10;            %Number of rolls in part a
pa = 0.5;           %Probability of an even number being rolled

kb = 9;             %There must be a success every 9 rolls in part b
Nb = 9;             %Number of rolls in part b
pb = 2/3;           %Probability of rolling a number other than 3 or 5

kc = 11;            %Success defined as at least 11 prime numbers in part c
Nc = 30;            %Number of rolls in part c
pc = 1/3;           %Probability of rolling a 3 or a 5

kd = 4;             %Success must happen more than 4 times every 8 rolls
Nd = 8;             %Number of rolls in part d
pd = 0.5;           %Probability of rolling a number greater than 3

rng('shuffle');     %Used to generate a random stream each program run

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 0;                          %Number of successful trials
k = 0;                          %Number of successful rolls
for c = 1:L                     %Repeats trials until L is reached
    for i = 1:Na                %Repeats rolls, different depending on part
        Roll = DiceRoll(S);     %Call for a random face number
        if(rem(Roll,2) == 0)    %success if roll is an even number
            k = k + 1;          %Increments k if it is a successful roll
        end
    end
    if(k == ka)                 %If k equals 5 successes, K is incremented
       K = K + 1;
    end
    k = 0;                      %k is set equal to zero for the next trial
end
Empirical_a = K / L;                  %Probability is found from observed
Theoretical_a = bern(ka, Na, pa);     %Theoretical is found from bernoulli

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 0;                                  %Number of successful trials
k = 0;                                  %Number of successful rolls
for c = 1:L                             %Repeats trials until L is reached
    for i = 1:Nb
        Roll = DiceRoll(S);             %Call for a random face number               
        if((Roll ~= 3) && (Roll ~= 5))  %success if roll is not 3 or 5
            k = k + 1;                  %Increments k if it is a successful roll
        end
    end
    if(k == kb)                  %If k equals 9, K is incremented
       K = K + 1;
    end
    k = 0;                       %k is set equal to zero for the next trial
end
Empirical_b = K / L;               %Probability is found from observed
Theoretical_b = bern(kb, Nb, pb);  %Theoretical is found from bernoulli

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 0;                                  %Number of successful trials
k = 0;                                  %Number of successful rolls
for c = 1:L                             %Repeats trials until L is reached
    for i = 1:Nc
        Roll = DiceRoll(S);             %Call for a random face number                 
        if((Roll == 3) || (Roll == 5) || (Roll == 2))  %success if prime number is rolled
            k = k + 1;           %Increments k if it is a successful roll
        end
    end
    if(k >= kc)                  %If there are 11 or more successful rolls
       K = K + 1;                %K is incremented
    end
    k = 0;                       %k is set equal to zero for the next trial
end
Theoretical_c = 0;
for t = 1:11                    %Must sum the probability for all cases
    Theoretical_c = Theoretical_c + bern(t, Nc, pc);
end
Empirical_c = K / L;             %Probability is found from observed                   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 0;                                  %Number of successful trials
k = 0;                                  %Number of successful rolls
for c = 1:L                             %Repeats trials until L is reached
    for i = 1:Nd
        Roll = DiceRoll(S);        %Call for a random face number                
        if(Roll > 3)               %success if number is greater than 3
            k = k + 1;             %Increments k if it is a successful roll
        end
    end
    if(k > 4)                    %If there are more than 4 (half) rolls
       K = K + 1;                %that are successful then K is incremented
    end
    k = 0;                       %k is set equal to zero for the next trial
end
Empirical_d = K / L;             %Probability is found from observed
Theoretical_d = bern(5, Nd, pd) + bern(6, Nd, pd) + bern(7, Nd, pd) + ...
    bern(8, Nd, pd);             %Must sum the probability of all cases

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Use the perctdiff() function to find the percent difference of each part
percenta = perctdiff(Theoretical_a, Empirical_a);
percentb = perctdiff(Theoretical_b, Empirical_b);
percentc = perctdiff(Theoretical_c, Empirical_c);
percentd = perctdiff(Theoretical_d, Empirical_d);

%Print the results from part A
fprintf('\nPart A: probability that 5 out of 10 rolls has an even face value.')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_a, Empirical_a, percenta)

%Print the results from part B
fprintf('\n\nPart B: probability that in 9 rolls, 3 and 5 never appear.')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_b, Empirical_b, percentb)

%Print the results from part C
fprintf('\n\nPart C: probability that in 30 rolls, there are at least 11 prime numbers')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%'...
    , Theoretical_c, Empirical_c, percentc)

%Print the results from part D
fprintf('\n\nPart D: probability that in 8 rolls, the die face is greater than 3 more often than not')
fprintf('\n Theoretical: %0.4f      Empirical: %0.4f    %% Difference: %0.4f%%\n\n\n'...
    , Theoretical_d, Empirical_d, percentd)




