%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: Lab_7_223.m
% Author: Karmyn VonEhr
% Date: 3/18/2020
% Instructor: Prof. Baine
% Description:  This program takes a given CDF and plots the 3D
% representation of the CDF, the marginal CDFs, the PDF, and the marginal
% PDFs. Each sections determines these graphs emipirically and
% analytically. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clc

s = 1/5;                                     %scale for range divisions
[x,y] = meshgrid(0:s:15, 0:s:15);            %Mesh ranges
Fxy = 1 - exp(-x./3) - exp(-y./2) + exp(-(x./3 + y./2)); %given CDF

%%%%%%%%%%%%%%%%%%% PART 4 %%%%%%%%%%%%%%%%%%%
figure;
mesh(x,y, Fxy)                   %3D plot of the CDF, Fxy
view(-60, 50)
xlabel('x'); ylabel('y'); zlabel('Fxy(x,y)');
title("Given Fxy(x,y)");

%%%%%%%%%%%%%%%%%%% PART 5 %%%%%%%%%%%%%%%%%%%
figure;
subplot(1,2,1);
plot(x, Fxy); grid; xlabel('x'); ylabel('fx');  %2D empircal of x marginal
title("Empirical Fx(x)");

x = 0:s:15;
Fx = 1 - exp(-x./3);                %analytical equation for x marginal

subplot(1,2,2);
plot(x, Fx); grid; xlabel('x'); ylabel('Fx'); %plot of analytical Fx
title("Analytical Fx(x)");

figure;
subplot(1,2,1);
plot(y, Fxy); grid; xlabel('y'); ylabel('fy');  %2D empirical of y marginal
title("Empirical Fy(y)");

Fy = 1 - exp(-y./2);                %analytical equation for y marginal

subplot(1,2,2);
plot(y, Fy); grid; xlabel('y'); ylabel('Fy'); %plot of analytical Fy
title("Analytical Fy(y)");

%%%%%%%%%%%%%%%%%%% PART 6 %%%%%%%%%%%%%%%%%%%
[x,y] = meshgrid(s:s:15, s:s:15);
figure;
subplot(1,2,1);
fxy1 = diff(Fxy,1,1)./s;
efxy = diff(fxy1,1,2)./s;                   %empirically determined PDF
mesh(x,y,efxy)                              %3D plot of empirical PDF
view(80, 20)
xlabel('x'); ylabel('y'); zlabel('fxy');
title("Empirical fxy");

subplot(1,2,2);
afxy = (1/6).*exp(-(x./3 + y./2));          %analytically determined PDF
mesh(x,y, afxy)                             %3D plot of analytical PDF
view(80, 20)
xlabel('x'); ylabel('y'); zlabel('fxy');
title("Analytical fxy");

%%%%%%%%%%%%%%%%%%% PART 7 %%%%%%%%%%%%%%%%%%%
ydim = 1;
xdim = 2;

x = s:s:15;
efx = s.*trapz(efxy,ydim);  %Partial integral for empirical x marginal PDF
figure;
subplot(1,2,1);
plot(x, efx); grid; xlabel('x'); ylabel('fx');%Plot of empirical x marg PDF
title("Empirical fx(x)");

afx = (1/3).*exp(-x./3);    %analytical y marginal PDF
subplot(1,2,2);
plot(x, afx);grid; xlabel('x'); ylabel('Fx');%Plot of analytical x marg PDF
title("Analytical fx(x)");

efy = s*trapz(efxy,xdim);   %Partial integral for empirical y marginal PDF
figure;
subplot(1,2,1);
plot(y, efy); grid; xlabel('y'); ylabel('fy');%Plot of empirical y marg PDF
title("Empirical fy(y)");

afy = (1/2).*exp(-y./2);    %analytical y marginal PDF
subplot(1,2,2);
plot(y, afy);grid; xlabel('y'); ylabel('Fy');%Plot of analytical y marg PDF
title("Analytical fy(y)");



