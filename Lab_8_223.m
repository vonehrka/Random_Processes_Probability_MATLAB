%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: Lab_8_223.m
% Author: Karmyn VonEhr
% Date: 3/27/2020
% Instructor: Prof. Baine
% Description:  Program uses linear regression analysis to evaluate
% relationship between random variables. Multivariable linear regression
% was practiced with matrix calculations. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clc

%%%%%%%%%%%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%%%%%
baseline = load('Baseline.txt','-ascii');   
X = baseline(:,1);       %separate input data to individual vectors
Y = baseline(:,2);
x = linspace(min(X),max(X),1000);   

[CovBase,CorrBase] = Estimates(X,Y);        %function call
alphaBase = CorrBase .* (std(Y) ./ std(X)); %Alpha calculation
betaBase = mean(Y) - alphaBase .* mean(X);  %Beta calculation
LS = alphaBase.* x + betaBase;              %Predicted output
errorBase = ((1/(length(Y) -1)).* sum((Y - (alphaBase .*...
    X + betaBase)).^2)) / var(Y);           %Error for extra analysis

reperfusion = load('Reperfusion.txt','-ascii');
X1 = reperfusion(:,1);    %separate input data to individual vectors
Y1 = reperfusion(:,2);
x1 = linspace(min(X1),max(X1),1000);

[CovRep,CorrRep] = Estimates(X1,Y1);        %Function call
alphaRep = CorrRep .* (std(Y1) ./ std(X1)); %Alpha calculation
betaRep = mean(Y1) - alphaRep .* mean(X1);  %Beta calculation
LS1 = alphaRep .* x1 + betaRep;             %Predicted output
errorRep = ((1/(length(Y1) -1)).* sum((Y1 - (alphaRep .* ...
    X1 + betaRep)).^2))/var(Y1);            %Error for extra analysis

figure;     %Baseline data plot and regression line
subplot(1,2,1);
hold on
scatter(X,Y,5,'filled');
plot(x,LS, 'Linewidth',2); grid; 
xlabel('Electrical Data'); ylabel('Pressure Data');
title("Baseline.txt ");
hold off

subplot(1,2,2);     %Reperfusion data plot and regression line
hold on
scatter(X1,Y1,5,'filled');
plot(x1, LS1,'Linewidth',2); grid; 
xlabel('Electrical Data'); ylabel('Pressure Data');
title("Reperfusion.txt");
hold off

%%%%%%%%%%%%%%%%%%%%%%%% PART 3 %%%%%%%%%%%%%%%%%%%%%%%%
blackbox = load('lab8_data.mat');
A = blackbox.A';            %separate input data into usable vectors
B = blackbox.B';
Ones = ones(1000,1);
M = [A B Ones];             %matrix concatination of desired vectors
OUT = blackbox.Vout';

MT = inv((M.')* M) * (M.') * OUT;   %pseudo-inverse solution
alphaBOX1 = MT(1);                  %value assignments
alphaBOX2 = MT(2);
betaBOX = MT(3);

%Error calculation from given equation for Emin^2
Error = ( (1/ (length(OUT) -1)) * sum((OUT - (alphaBOX1*A + ...
    alphaBOX2*B + betaBOX)).^2) )/ var(OUT);    

Atst = linspace(min(A),max(A),1000);        %1-D test vector for A
Btst = linspace(min(B),max(B),1000);        %1-D test vector for B
OUTtst = alphaBOX1 .* Atst + alphaBOX2 .*Btst + betaBOX; %Predicted output

figure;
hold on
scatter3(A,B,OUT,5,'filled');grid;          %3D scatter plot of given data
ylabel('B'); xlabel('A'); zlabel('OUT');
title("Black Box");
view(40,10)
plot3(Atst, Btst, OUTtst);                  %Plot of predicted output
hold off


function [CovXY,CorrCoe] = Estimates(X,Y)
    CovXY =  (1./(length(X)-1)) .* sum(X.*Y - mean(X).*mean(Y));
    CorrCoe = CovXY ./ (std(X).*std(Y));
end



