clear all
%close all
clc

% Define the details of the table design problem
nVar = 3;
ub = [300 3 30];
lb = [0 0 0];

%define plant's parameters
M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.8;
l = 0.3;

% Define the GA's paramters
PopSize = 20;
MaxGenerations = 100;

%simulate GA
open('Tugas4_07111740000034.slx')
options = optimoptions(@ga, 'PopulationSize', PopSize, 'MaxGenerations', ...
    MaxGenerations, 'CreationFcn', @gacreationuniform, 'SelectionFcn', ...
    @selectionstochunif, 'CrossoverFcn', @crossoversinglepoint, ...
    'MutationFcn', {@mutationuniform,0.1}, 'EliteCount', 0.05*PopSize, ...
    'Display', 'diagnose', 'PlotFcn', {@gaplotbestf, @gaplotbestindivg}, ...
    'OutputFcn', @myfun);
[x,fval,exitflag,output,population,scores] = ga(@(x)CostFunction(x), ...
    nVar,[],[],[],[],lb,ub,[],options)
rmsestep = sqrt(mean((y-r).^2));