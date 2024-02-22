clc; clearvars; close all;

%import data from file to workspace
data = readtable("2_LED_T8.csv");

%convert 'data' variable type from table to array
%column 1 [TIME]
t = table2array(data(:,"X")); 
%column 2 [v(t)]
v = table2array(data(:,"CH1"));
%column 1 [i(t)]
i = table2array(data(:,"CH2"));

%Plotting first graph by t to x-axis and v to y-axis
%set first graph to use left y-axis
yyaxis left;
plot(t,v);
grid on;
%label x-axis to "t"
xlabel("t");
%label y-axis to "v(t)"
ylabel("v(t)");

%Plotting second graph t to x-axis and i to y-axis
%Set second graph to use right y-axis
yyaxis right;
plot(t,i);
%set limit for y axis
ylim([-1 1]);
grid on;
%label x-axis to "t"
xlabel("t");
%label y-axis to "i(t)"
ylabel("i(t)");
%title the figure using fontsize 12
title(['\fontsize{12}LED T8']);
%set a position and size of graph to mimic with scope image
set(gcf,'position',[0,0,640,468]);
