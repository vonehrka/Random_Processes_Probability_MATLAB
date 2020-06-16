%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: missile.m
% Author: Karmyn VonEhr
% Date: 2/3/2020
% Instructor: Prof. Baine
% Description:  Accepts probabilites of individual missiles hitting the
% the target and the probabilities of a certain number of targets hitting
% the target. The function returns flags for each missile that hit, a flag
% if the target was destroyed, and the sum of the number of missiles that
% hit. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,B,C,q, sum] = missile(a,b,c,h1,h2,h3)

%Probability of A hitting the target
A = randsrc(1,1,[0,1;(1-a),a]);

%Probability of B hitting the target
B = randsrc(1,1,[0,1;(1-b),b]);

%Probability of C hitting the target
C = randsrc(1,1,[0,1;(1-c),c]);

%Random number for the target getting hit
sinkprob = rand();

%number of missiles hit
sum = A + B + C;

%Probability of one hitting the target
if(sum == 1)
    if(sinkprob < h1)
        q = 1;
    else 
        q = 0;
    end
end

%Probability of two hitting the target
if(sum == 2)
    if(sinkprob < h2)
        q = 1;
    else 
        q = 0;
    end
end

%Probability of all three hitting the target
if(sum == 3)
    if(sinkprob < h3)
        q = 1;
    else 
        q = 0;
    end
end

%Probability of none hitting the target
if(sum == 0)
    q = 0;
end

end