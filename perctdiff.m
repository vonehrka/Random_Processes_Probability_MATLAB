%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: perctdiff.m
% Author: Karmyn VonEhr
% Date: 2/3/2020
% Instructor: Prof. Baine
% Description:  Accepts two variables and takes the percent difference
% between the two. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function percent = perctdiff(a,b)    %takes the theoretical and empirial values
    percent = 100 * abs((a - b)/a);  %returns the percent difference
end
