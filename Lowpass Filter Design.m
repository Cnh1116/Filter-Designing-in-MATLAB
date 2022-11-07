%clear; close all;
%define the constant values
% Carson Holland, Collab with Kevin Seets------------------------
%Low Pass Filter Design

f_sample= 44000; %Fs = 44 kHz
delta_f = (11000-10000)/f_sample; %Normalized Frequency
N = 151; %151 Terms
N_terms = (N-1)/2;
f_pe = 10000;% Passband Edge
TW=5.98*N/f_sample; %Transition Width


f_cutoff =f_pe+TW/2; %Cutoff Frequency = Halfway between passband and stopband

OmegaL_cutoff = (2*pi*f_cutoff)/f_sample;

window = hamming(N); %window of choice
%wh = blackman(n);

h_0 = (OmegaL_cutoff)/pi; % Based on the lowpass filter, if n = 0
h = zeros(N_terms,1);

for iterator = -N_terms:N_terms
 iter = iterator + (N+1)/2;
 if(iterator == 0)
 h(iter) = h_0;
 
 else
 h(iter) = (sin(OmegaL_cutoff*iterator)/(pi*iterator))*window(iter); %Low Pass Equation

 end
end


figure
freqz(h,1,440000,f_sample);
title("Low Pass 151-term FIR filter, Hamming Window")
grid on