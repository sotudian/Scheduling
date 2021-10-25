clear
clc;
% SHAHAB SOTUDIAN-------94125091
% SCHEDULING ASSIGNMENT----NEIGHBORHOOD SEARCH
% criteria --- Tardiness
% 10 Jobs
% Flow Shop
% 2 Machines
load ('Data.mat');
IntialTardiness=TardiFunction(JobsData);
Max_iteration=30;
tardiness=IntialTardiness;


for S=1:Max_iteration
  
    for i=1:1:9
         JobsData(:,[i,i+1])=JobsData(:,[i+1,i]);
         TAR(i)=TardiFunction(JobsData);
         if tardiness>=TAR(i)
    tardiness=TAR(i);
    best=JobsData;
         end
         JobsData(:,[i+1,i])=JobsData(:,[i,i+1]);
    end
    
    X = [' Iteration  ',num2str(S),'    ====>    ',' Maximum  Tardiness = ',num2str(tardiness)];
    disp(X);
     sprintf('\n');
    JobsData=best;
    E(2,S)=tardiness; 
    E(1,S)=S;


end


Scheduling=best(4,:);
NumberofIteration=S;
disp('============================================================================================')
disp('********************************************************************************************')
disp([ ' Best Schedule = ' ,num2str(Scheduling)])
disp([ ' Number Of Iteration = ' , num2str(NumberofIteration)])
disp([ ' Best Maximum Tardiness = ' ,num2str(tardiness)])
disp('********************************************************************************************')
disp('============================================================================================')
plot(E(1,:),E(2,:),'c','LineWidth',2)
xlabel('Iteration')
ylabel('Maximum  Tardiness');
title('Neighborhood Search Alg')



