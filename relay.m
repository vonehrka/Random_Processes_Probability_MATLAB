%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: relay.m
% Author: Karmyn VonEhr
% Date: 2/3/2020
% Instructor: Prof. Baine
% Description: Accepts probabilities of selecting a relay at random
% from a manufacturer and probabilties of a defective relay from a 
% respective manufacturer. The function returns a flag corresponding to
% the manufacturer chosen, and a flag if the relay was defective. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [M1,M2,M3,D] = relay(m1,m2,m3,d1,d2,d3)

%Initialize all variables as zero
M1 = 0; 
M2 = 0;
M3 = 0;
D = 0;

%Random number for the manufacturer type and if the relay is defective
manufacturer = rand();
defect = rand();

%Set flags if random number is within respective ranges
if(manufacturer < m1)
    M1 = 1;
end

if((m1 <= manufacturer) && ( manufacturer < (m1 + m2)))
    M2 = 1;
end

if(((m1 + m2) <= manufacturer) && (manufacturer <= 1))
    M3 = 1;
end
    
%Set defective flag if defect random number is within given probabilities.
if(M1 == 1)
    if(defect < d1)
        D = 1;
    end
end

if(M2 == 1)
    if(defect < d2)
        D = 1;
    end
end

if(M3 == 1)
    if(defect < d3)
        D = 1;
    end
end

end