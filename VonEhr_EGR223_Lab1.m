%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: Introduction to MATLAB
% Filename: VonEhr_EGR223_Lab1.m
% Author: Karmyn VonEhr
% Date: 1/10/2020
% Instructor: Prof. Baine
% Description:  Lab used to gain unterstanding of how to use MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 5;                                  %signal frequency is 5 Hz
A = 1;                                   %Amplitude of 1
offset = pi/ 4;                          %Phase offset of 45 degrees (radians)
N = 4;                                   %Data length is 4 points (4 cycles)
time = 0:1/(100*fs):N*(1/fs);            %Creates a time axis (time = 0:1/(100*fs): N/fs;)
signal = A*sin(2*pi*fs*time + offset);   %Clean signal used for variance and standard deviation.
SNR = -28;                               %Variable to be changed for final question

corrupt1 = signal + standevN(signal,6)*rand(1,401);   %SNR of 6dB
corrupt2 = signal + standevN(signal,0)*rand(1,401);   %SNR of 0dB
corrupt3 = signal + standevN(signal,-6)*rand(1,401);  %SNR of -6dB
toonoisy = signal + standevN(signal,SNR)*rand(1,401); %No longer a sinusoid

%Data Plots
figure;
subplot(3,1,1); %1st of 3 plots in a single column
plot(time,corrupt1); grid; xlabel('Time (sec)'); ylabel('Amplitude');
title('6dB SNR Noise');
subplot(3,1,2); %2nd of 3 plots in a single column
plot(time,corrupt2); grid; xlabel('Time (sec)');ylabel('Amplitude');
title('0dB SNR Noise');
subplot(3,1,3); %3rd of 3 plots in a single column
plot(time,corrupt3); grid; xlabel('Time (sec)');ylabel('Amplitude');
title ('-6dB SNR Noise');

figure; %anything below -28 dB is no longer obviously sinusoidal
plot(time, toonoisy); grid; xlabel('Time (sec)'); ylabel('Amplitude');
title("SNR of -28, Sinusoidless");


function output = standevN(sig, snr)            %function accepts the SNR, and clean signal
   x = 10^(snr/10);                             %converts SNR to ratio value
   output = sqrt(var(sig)/x);                   %Takes the square root of the noise variance for the standdev
end
