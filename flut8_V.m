clc, close , clearvars all
data = readtable("1_Fluorescent_T8.csv");

a = table2array(data(:,1));
b = table2array(data(:,2));
c = table2array(data(:,3));

%find fft
%define fs = sampling frequency
fs = 1/(a(2)-a(1));
fourier = fft(b);
frequency = fs * (0:(length(b)/2))/length(b);
magnitude = abs(fourier(1:length(b)/2+1));
plot(frequency,magnitude)
grid on
title("FFT Voltage Signal of Fluorescent T8")
xlabel("Frequency (Hz)")
ylabel("Voltage (V)")
%find THD
fundamental = find(magnitude == max(magnitude));
h1 = magnitude(fundamental);
harmonic = magnitude;
harmonic(fundamental)=0;
THD = sqrt(sum(harmonic.^2))/h1 * 100