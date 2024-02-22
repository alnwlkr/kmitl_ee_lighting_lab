clc; clearvars; close all;

%import data from file to workspace
data = readtable("4_LED_Incandescent.csv");
%set name variable for labeling
name = "LED Incandescent";

%convert 'data' variable type from table to array
%column 1 [TIME]
t = table2array(data(:,"X")); 
%column 2 [v(t)]
v = table2array(data(:,"CH1"));
%column 1 [i(t)]
i = table2array(data(:,"CH2"));

%Plotting first graph by t to x-axis and v to y-axis
%Initialize figure to 4 x 1 and set position of plotting to 1
subplot(411);
plot(t,v);
grid on;
%label x-axis to "t"
xlabel("t");
%label y-axis to "v(t)"
ylabel("v(t)");
%title the figure using fontsize 12
title(name);
subtitle('v(t)');

%Plotting second graph t to x-axis and i to y-axis
subplot(412);
plot(t,i);
grid on;
%label x-axis to "t"
xlabel("t");
%label y-axis to "i(t)"
ylabel("i(t)");
subtitle('i(t)');

%plotting spectrum of harmic using 'myfft' function 
%by passing variable 't','v',type of signal, 'name' and plotting postion
v_mag = myfft(t,v,"v",name,413);
i_mag = myfft(t,i,"i",name,414);
%set size and position of figure
set(gcf,'position',[960,0,540,810]);
%Compute THDv and THDi using 'mythd' function
thdv = mythd(v_mag);
thdi = mythd(i_mag);
%print out the value that computed with a name.
fprintf("%s \nTHDv = %f\nTHDi = %f\n",name,thdv,thdi);

%defining function to use above

%myfft function take 5 parameter and output 1 parameter
%'t' for time array, 'sig' for signal array
%'sig_type' for labeling it's voltage or current 
%'sig_type' input is "v" or "i" only !!
% 'title_name' for labeling the name of figure
% 'plotpos' for plotting position
% Output parameter is 'magnitude' which is array contain magnitude
% of harmonic spectrum

function [magnitude] = myfft(t,sig,sig_type,title_name,plotpos)
    if sig_type == "v"
        sig_name = "Voltage";
        sig_u = " (V)";
    else if sig_type == "i"
        sig_name = "Current";
        sig_u = " (A)";
    else
        end
    end
        
    fs = 1/(t(2)-t(1));
    fourier = fft(sig);
    frequency = fs * (0:(length(sig)/2))/length(sig);
    magnitude = abs(fourier(1:length(sig)/2+1));
    subplot(plotpos);
    plot(frequency,magnitude)
    grid on
    subtitle(['FFT '+sig_name+' Signal of '+title_name])
    xlabel("Frequency (Hz)");
    ylabel([sig_name+' '+sig_u])
end

%mythd function take 1 parameter and output 1 parameter 
% 'magnitude' for harmonic spectrum array
% Output 'thdo' is computed THD value of the signal by percent (%)
function [thdo] = mythd(magnitude)
    fundamental = find(magnitude == max(magnitude));
    h1 = magnitude(fundamental);
    harmonic = magnitude;
    %Set Fundamental Spectrum to zero for easier computation
    harmonic(fundamental)=0;
    thdo = sqrt(sum(harmonic.^2))/h1 * 100;
end
