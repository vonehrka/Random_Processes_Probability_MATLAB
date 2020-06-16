function [bin_data, rcv_data] = gen_rdata(Nsym, SNR, p)
% Simulation of baseband binary pulse transmission
% Nsym - number of binary points and Gaussian pulses
% SNR  - desired SNR in dB
% p    - prob of a 1 vs. a 0 (usually 0.5)
% bin_data: Nsym point vector of 1's and 0's; random binary data
% rcv_data: Nsym x 20 vector of pulses of above data with given SNR
%
% Note: function uses a 20 point Gaussian pulse shape of Ep = 1
% Usage: [bin_data, rcv_data] = gen_rdata(Nsym, SNR, p);

if(Nsym < 0)
    error('Incorrect number of symbols');
end
if(p < 0 || p > 1)
    error('Prob of 1 incorrect');
end
bin_data = zeros(Nsym, 1);
pdata = zeros(0,1);

puls =    [0            % 20 point Gaussian pulse shape
   0.007617389414865    % adjusted for Ep = 1
   0.031455342184539
   0.070092094352314
   0.120328669495781
   0.177475320616964
   0.235843683614484
   0.289387944478742
   0.332414859116208
   0.360269954756471
   0.369907985284340
   0.360269954756471
   0.332414859116208
   0.289387944478742
   0.235843683614484
   0.177475320616964
   0.120328669495781
   0.070092094352314
   0.031455342184539
   0.007617389414865];

ep = trapz(puls.*puls);   % finds Ep for given pulse; currently at 1

for i = 1:Nsym
    tmp = rand;
    if(tmp <= p)
        bin_data(i) = 1;
        pdata = [pdata;puls];
    else
        bin_data(i) = 0;
        pdata = [pdata;-puls];
    end
end

snr = 10.0.^(SNR./10.0);          % dB to linear
n_std = sqrt(ep./snr);           % noise std for desired SNR
rcv_data = pdata + n_std.*randn(length(pdata),1);   % r(t)

end