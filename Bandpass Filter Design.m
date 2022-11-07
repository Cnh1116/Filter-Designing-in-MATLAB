clear; close all;
% Carson Holland, Collab with Kevin Seets----------------------------------
%Band Pass Filter Design

%Parameters----------------------------------------------------------------
N = 33;
N_terms = (N-1)/2;
f_sample=12000; %12kHz Sample Frequency
f_pl=1250;% Low stop band
f_ph=4750;% High stop band
TW= 1250; %Transition Width from stopband to passband


f_cutoff_lowpass = 1875; %f_pl + TW/2
f_cutoff_highpass = 4125; %f_ph + TW/2

OmegaL_cutoff = (2*pi*f_cutoff_lowpass)/f_sample;
OmegaH_cutoff = (2*pi*f_cutoff_highpass)/f_sample;
wh=hamming(N);
h_L0 = (OmegaL_cutoff)/pi; % Based on the lowpass filter
h_h0 = (pi-OmegaH_cutoff)/pi; % Based on the highpass filter

h_BP0 = (OmegaH_cutoff-OmegaL_cutoff)/pi; % Based on the Band Pass filter
%define the vectors
h_l = zeros(N_terms,1);
h_h = zeros(N_terms,1);
h_SB=zeros(N_terms,1);
for iterator = -N_terms:N_terms
 iter = iterator + (N+1)/2;
 if(iterator == 0)
 h_l(iter) = h_L0;
 h_h(iter)=h_h0;
 h_SB(iter)=h_BP0;
 else
 h_l(iter) = -(sin(OmegaL_cutoff*iterator)/(pi*iterator))*wh(iter);
 h_h(iter) = +(sin(OmegaH_cutoff*iterator)/(pi*iterator)).*wh(iter);
 h_SB(iter)=(h_l(iter)+h_h(iter));

 end
end


figure
freqz(h_SB,1,24000,f_sample);
title("Band Pass 33-terms FIR filter")
grid on








