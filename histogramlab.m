%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: histogram.m
% Author: Karmyn VonEhr
% Date: 2/12/2020
% Instructor: Prof. Baine
% Description:  Accepts max, min, desired number of bins, and an input
% data vector. The data vector is sorted through, and the values are 
% placed into bins based on logic equations. A normalized vector is
% returned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function histovector = histogramlab(max, min, Nbins,inptvect)
binsize = (max - min) / Nbins;      %bin size given inputs
histovector = (1:Nbins);            %vector of zeros created with the for
for i = 1 : Nbins                   %loop (zeros function couldn't contain
    histovector(i) = 0;             %the number of bins desired)
end
sum = 0;
L = length(inptvect);               %length of the input vector
for i = 1 : Nbins                   %values placed in each bin 
    for j = 1 : L                   %loops sort input vector into bins
        if((inptvect(j) <= (min + i * binsize)) && (inptvect(j) > ...
                (min + (i-1)* binsize))) 
            histovector(i) = histovector(i) + 1;
        end                         
        %two if statements to place elements that are outside of bin range
        if((inptvect(j) < min) && (i == 1))
            histovector(1) = histovector(1) + 1;
        end
        
        if((inptvect(j) > (min + Nbins*binsize)) && (i == Nbins))
          histovector(Nbins) = histovector(Nbins) + 1;
        end 
    end
    sum = sum + binsize * histovector(i);
end
%final vector is truncated from the for loops to only what is desired
histovector = histovector(:, 1:Nbins);
for i = 1:Nbins
    %Each bin height is normalized by dividing by the sum of the areas
    histovector(i) = histovector(i) / sum; 
end 
end








