clear
clc;
% SHAHAB SOTUDIAN-------94125091
% SCHEDULING ASSIGNMENT----TABU SEARCH
% criteria --- Tardiness
% 10 Jobs
% Flow Shop
% 2 Machines
S=2;
p=0;
B(2)=inf;
B(1)=inf;
load ('Data.mat');
IntialTardiness=TardiFunction(JobsData);
Max_iteration=30;
tardiness=IntialTardiness;
%*********************************

for S=2:Max_iteration
 p=p+1;   
while B(S)<=B(S-1) && S<=Max_iteration
S=S+1;

    for i=1:1:9
         JobsData(:,[i,i+1])=JobsData(:,[i+1,i]);
         TAR(i)=TardiFunction(JobsData);
         JobsData(:,[i+1,i])=JobsData(:,[i,i+1]);
    end
    
    if p==1
    E(1,S-2)=S-2;
    E(2,S-2)=min(TAR);
    X = [' Iteration  ',num2str(S-2),'    ====>>>    ',' Tardiness = ',num2str(min(TAR))];
    disp(X);
     sprintf('\n');
    end  
if tardiness==min(TAR)
    TAR2 = sort(TAR(:));
    B(S) = TAR2(2);
else
    B(S)=min(TAR);
end

if B(S)==TAR(1)
    JobsData(:,[1,2])=JobsData(:,[2,1]);
   
elseif B(S)==TAR(2)
    JobsData(:,[2,3])=JobsData(:,[3,2]);
     
elseif B(S)==TAR(3)
    JobsData(:,[3,4])=JobsData(:,[4,3]);
     
elseif B(S)==TAR(4)
    JobsData(:,[4,5])=JobsData(:,[5,4]);
    
elseif B(S)==TAR(5)
    JobsData(:,[5,6])=JobsData(:,[6,5]);
   
elseif B(S)==TAR(6)
    JobsData(:,[6,7])=JobsData(:,[7,6]);
    
elseif B(S)==TAR(7)
    JobsData(:,[7,8])=JobsData(:,[8,7]);

elseif B(S)==TAR(8)
    JobsData(:,[8,9])=JobsData(:,[9,8]);

elseif B(S)==TAR(9)
    JobsData(:,[9,10])=JobsData(:,[10,9]);

end
new=JobsData;
end
end
Scheduling=[new(4,1) new(4,2) new(4,3) new(4,4) new(4,5) new(4,6) new(4,7) new(4,8) new(4,9) new(4,10)];
NumberofIteration=S-1;
TARDINESS=B(S);
 


disp('********************************************************************************************')
disp('********************************************************************************************')
disp([ ' Best Schedule = ' ,num2str(Scheduling)])
disp([ ' Number Of Iteration = ' , num2str(NumberofIteration)])
disp([ ' TARDINESS = ' ,num2str(TARDINESS)])
disp('********************************************************************************************')
disp('********************************************************************************************')
plot(E(1,:),E(2,:),'g','LineWidth',2)
xlabel('Iteration')
ylabel('Best TARDINESS');
title('Tabu Search Alg')



