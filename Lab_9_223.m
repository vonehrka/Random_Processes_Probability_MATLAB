%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: Lab_9_223.m
% Author: Karmyn VonEhr
% Date: 4/8/2020
% Instructor: Prof. Baine
% Description:  This program uses hypothesis testing to validate the
% probability of dice rolls and to analyze the significance of a provided
% data set. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clc
rng('shuffle');     %Used to generate a random stream each program run

trials1 = 30;       %One trial of 30 rolls
confidence1 = 0.95;
truemean = 7;
trials2 = 2500;     %2500 trials of 30 rolls
confidence2 = 0.75;

%count variabls for successful trials
successes1 = 0;
successes2 = 0;
successes3 = 0;
successes4 = 0;

%%%%%%%%%%%%%%%%%%%%%%% PART I %%%%%%%%%%%%%%%%%%%%%%%%
fprintf("FAIR DIE\n");
test1 = TestValues(truemean,trials1,confidence1,DiceRoll(6,trials1),...
    DiceRoll(6,trials1));
fprintf("30 ROLLS, 95%% CONFIDENCE\n");
print(test1);

%success percent calculation fo 95% confidence
for n = 1:trials2+1
    new = TestValues(truemean,trials1,confidence1,DiceRoll(6,trials1),...
    DiceRoll(6,trials1));
    successes1 = successes1 + new(6);
end
percent1 = successes1/trials2 * 100;
fprintf("2500 Trials, 95%% confidence, %% Success = %.2f\n", percent1);

%success percent calculation for 75% confidence
for n = 1:trials2+1
    new1 = TestValues(truemean,trials1,confidence2,DiceRoll(6,trials1),...
    DiceRoll(6,trials1));
    successes2 = successes2 + new1(6);
end
percent2 = successes2/trials2 * 100;
fprintf("2500 Trials, 75%% confidence, %% Success = %.2f\n\n\n", percent2);

%%%%%%%%%%%%%%%%%%%%%%% PART II %%%%%%%%%%%%%%%%%%%%%%%%
face1 = 3;  %face value to be biased
face2 = 2;  %face value to be biased
p1 = 0.7;   %probability of bias
p2 = 0.7;   %probability of bias

fprintf("UNFAIR DICE\nDie 1: %d biased %.1f\nDie 2: %d biased %.1f\n\n",...
    face1,p1,face2,p2);
unfairDice1 = UnfairDiceRoll(face1,p1,6,trials1); 
unfairDice2 = UnfairDiceRoll(face2,p2,6,trials1);
test4 = TestValues(truemean,trials1,confidence1,unfairDice1,unfairDice2);
fprintf("30 ROLLS, 95%% CONFIDENCE\n");
print(test4);

for n = 1:trials2+1
new2 = TestValues(truemean,trials1,confidence1,...
   UnfairDiceRoll(face1,p1,6,trials1), UnfairDiceRoll(face1,p1,6,trials1));
    successes3 = successes3 + new2(6);
end
percent3 = successes3/trials2 * 100;
fprintf("2500 Trials, 95%% confidence, %% Success = %.2f\n", percent3);

for n = 1:trials2+1
new3 = TestValues(truemean,trials1,confidence1,...
   UnfairDiceRoll(face1,p1,6,trials1), UnfairDiceRoll(face1,p1,6,trials1));
    successes4 = successes4 + new3(6);
end
percent4 = successes4/trials2 * 100;
fprintf("2500 Trials, 75%% confidence, %% Success = %.2f\n\n\n", percent4);

%%%%%%%%%%%%%%%%%%%%%%% PART III %%%%%%%%%%%%%%%%%%%%%%%%
systolic = load('systolic.txt','-ascii');  %input data
control = systolic(:,1);
company1 = systolic(:,2);
company2 = systolic(:,3);
patients = 25;
confid = 0.95;  
confid1 = 0.9;  
P1 = (1 + confid) / 2;      %probability for T function
P2 = (1 + confid1) / 2;     %probability for T function

%variance calculations
controlvar = var(control);
company1var = var(company1);
company2var = var(company2);

%standard Deviation calculations
stdcompany1 = sqrt((controlvar + company1var)/patients);
stdcompany2 = sqrt((controlvar + company2var)/patients);
stdboth = sqrt((company1var + company2var)/patients);

%T statistic calculations
Tcompany1 = (mean(company1) - mean(control)) / stdcompany1;
Tcompany2 = (mean(company2) - mean(control)) / stdcompany2;
Tboth = (mean(company1) - mean(company2)) / stdboth;

%Degree of Freedom calculations
DOF1 = round(stdcompany1^4 /(1/(patients-1)*((controlvar/patients)^2 +...
    (company1var/patients)^2)));
DOF2 = round(stdcompany2^4 /(1/(patients-1)*((controlvar/patients)^2 +...
    (company2var/patients)^2)));
DOFb = round(stdboth^4 /(1/(patients-1)*((company1var/patients)^2 +...
    (company2var/patients)^2)));

%test bounds calculations
bounds1 = tinv(confid,DOF1);
bounds2 = tinv(confid,DOF2);
bounds3 = tinv(P1,DOFb);
bounds4 = tinv(P2,DOFb);

fprintf("Ho: Mean company > Mean control\n\n");
fprintf("Company 1 Test: -%.3f < %.3f \n", bounds1,Tcompany1);
fprintf("T = %.3f, DOF = %.3f, Confidence = 0.95, Significance = 0.05\n",Tcompany1, DOF1);
if(Tcompany1 >= -bounds1)
    fprintf("Fail to reject the null hypothesis. It can be concluded \n");
    fprintf("that company 1 does not significantly reduce blood pressure.\n");
else
    fprintf("Reject the null hypothesis. It can be concluded that \n");
    fprintf("company 1 does reduce blood pressure with 95%% confidence.\n\n");
end

fprintf("Company 2 Test: -%.3f < %.3f \n", bounds2,Tcompany2);
fprintf("T = %.3f, DOF = %.3f, Confidence = 0.95, Significance = 0.05\n",Tcompany2, DOF2);
if(Tcompany2 >= bounds2)   
    fprintf("Fail to reject the null hypothesis. It can be concluded \n");
    fprintf("that company 2 does not significantly reduce blood pressure.\n");
else
    fprintf("Reject the null hypothesis. It can be concluded that \n");
    fprintf("company 2 does reduce blood pressure with 95%% confidence.\n\n");
end

fprintf("Ho: Mean company1 = Mean company2\n\n");
fprintf("Both Company Comparison Test: -%.3f < %.3f < %.3f \n", bounds3,Tboth,bounds3);
fprintf("T = %.3f, DOF = %.3f, Confidence = 0.95, Significance = 0.05\n",Tboth, DOFb);
if((Tboth <= bounds3) && (Tboth > -bounds3))   
    fprintf("Fail to reject the null hypothesis. It can be concluded \n");
    fprintf("that there is not significant difference between the two drugs.\n\n");
else
    fprintf("Reject the null hypothesis. It can be concluded that \n");
    fprintf("there is significant difference between the two drugs with 95%% confidence.\n\n");
end

fprintf("Both Company Comparison Test: -%.3f < %.3f < %.3f \n", bounds4,Tboth,bounds4);
fprintf("T = %.3f, DOF = %.3f, Confidence = 0.90, Significance = 0.10\n",Tboth, DOFb);
if((Tboth <= bounds4) && (Tboth > -bounds4))   
    fprintf("Fail to reject the null hypothesis. It can be concluded \n");
    fprintf("that there is not significant difference between the two drugs.\n\n");
else
    fprintf("Reject the null hypothesis. It can be concluded that \n");
    fprintf("there is significant difference between the two drugs with 90%% confidence.\n\n");
end

%function for simlating fair dice
%returns vector of t dice rolls
function roll = DiceRoll(s,t)     %S is the number of sides
roll = randi([1,s],1,t);          %returns a random value from 1 to 6
end

%function for simulating unfair dice
%returns vector of t dice rolls
function roll = UnfairDiceRoll(fv,p,s,t)
roll = rand(1,t);
roll(roll <= p & roll >= 0) = fv;               %biased rolls
roll(roll ~= fv) = randi(s,1,sum(roll~=fv));    %other rolls
end

%function to calculate the values needed for dice roll tests
%returns mean, std, delta mean, bounds, and success flag
function [test] = TestValues(truemean,trials,confidence,Dice1,Dice2)
P = (1 + confidence) / 2;       %probability for t test bounds
DOF = trials - 1;               %degrees of freedom
Sum = Dice1 + Dice2;
SampleMean = mean(Sum);
SampleStd = std(Sum);
DeltaMean = (SampleStd / sqrt(trials)) * tinv(P,DOF);
bounds0 = truemean - DeltaMean;
bounds1 = truemean + DeltaMean;
if((SampleMean > bounds0)&&(SampleMean <= bounds1)) %determines success
    success = 1;
else
    success = 0;
end

test = [SampleMean SampleStd DeltaMean bounds0 bounds1 success];
end

%function to print dice roll test results
function print(test)
fprintf("Sample Mean = %0.3f\n",test(1));
fprintf("Sample Deviation = %0.3f\n",test(2));
fprintf("Delta Mean = %0.3f\n",test(3));
fprintf("Success = %d\n",test(6));
fprintf("Range %0.3f < %0.3f < %0.3f\n\n\n",test(4),test(1),test(5));
end
