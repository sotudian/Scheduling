clc
clear
close all
% SHAHAB SOTUDIAN-------94125091
% SCHEDULING ASSIGNMENT----Genetic Algorithm
% criteria --- Tardiness
% 10 Jobs
% Flow Shop
% 2 Machines

% parameters setting
load('JobsData.mat');
JOBS_DATA=data.P;
Num_Var=size(JOBS_DATA,1);
populationsize=6;
Max_iteration=60;
Percent_Of_Crossover=0.1;
Num_Cross=2*round((populationsize*Percent_Of_Crossover)/2);
l=1-Percent_Of_Crossover;
Num_Mutation=round(populationsize*l);

% initial population algorithm
K.x=[];
K.info=[];
K.fit=[];
population=repmat(K,populationsize,1);
for i=1:populationsize
    population(i).x=randperm(Num_Var);
    population(i).fit=TardiFunction(population(i).x,JOBS_DATA);
end
[value,index]=min([population.fit]);
gpopulation=population(index);

% main loop algorithm
BEST=zeros(Max_iteration,1);
MEAN=zeros(Max_iteration,1);
for iter=1:Max_iteration
   % crossover part
   CrossP=repmat(K,Num_Cross,1);
   CrossP=Crossover(CrossP,population,Num_Var,JOBS_DATA,Num_Cross);
   % mutation part
   MutationPop=repmat(K,Num_Mutation,1);   
   MutationPop=Mutation(MutationPop,population,Num_Var,JOBS_DATA,Num_Mutation,populationsize);
   [population]=[population;CrossP;MutationPop]; 
   [value,index]=sort([population.fit]); 
   population=population(index);
   gpopulation=population(1);
   population=population(1:populationsize); 
BEST(iter)=gpopulation.fit;
MEAN(iter)=mean([population.fit]);

disp([' Iteration ' num2str(iter) '    ====>    '  '  Best Maximum Tardiness = ' num2str(BEST(iter))])


end

% results 
disp('=====================================================================')
disp('*********************************************************************')
disp([ ' Best Schedule = '  num2str(gpopulation.x)])
disp([ ' Number Of Iteration = ' , num2str(Max_iteration)])
disp([ ' Best Maximum Tardiness = '  num2str(gpopulation.fit)])
disp('=====================================================================')
disp('*********************************************************************')

figure(1)
plot(BEST,'r','LineWidth',2)
xlabel('Iteration')
ylabel('Maximum Tardiness');
title('Genetic Algorithm')