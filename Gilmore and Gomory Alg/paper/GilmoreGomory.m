clear
clc;
% SHAHAB SOTUDIAN-------94125091
% SCHEDULING ASSIGNMENT----Gilmore and Gomory Alg
% 15 Jobs
% 2 Machines
load ('Data.mat');
table=[];
z=JobsData;
t=JobsData;
i=1;
% fi sorting
while i<=6
   s=find(t(3,:)==min(t(3,:)));
   
   if min(t(3,:))==1000
       break;
   end
   k=size(s);
                    if k(2)>1
             for j=1:(k(2))
             z(:,i+j-1)=t(:,s(j));
             end
             for j=1:(k(2))
               t(:,s(j))=1000;  
             end
                i=i+k(2);
                    else
              z(:,i)=t(:,s);
              t(:,s)=1000;
              i=i+1;
                    end
end

eQ=sort(JobsData(2,:));
table(1,:)=JobsData(1,:); 
table(2,:)=z(3,:);  
table(3,:)=z(2,:); 
table(4,:)=eQ;
b=table(3,:);

for i=1:6
    w=find(b(1,:)==eQ(1,i));
    table(5,i)=table(1,w(1));
    b(1,w(1))=1000;
    
end

for i=1:5
q=min(table(2,i+1),table(4,i+1))-max(table(2,i),table(4,i));
C(i)=max(0,q);
end
C(i+1)=1000000;
table(6,:)=C;
%% New arcs
for i=1:6
 SS(1,i)=table(1,i);
SS(2,i)=table(5,i);
end

disp( ' initial  Graph')
for i=1:6
    disp([ ' Arc ',num2str(i),'   ====>   ' , num2str(SS(1,i)),' - ',num2str(SS(2,i))])
      
end
 G=digraph(SS(1,:),SS(2,:),'OmitSelfLoops');
p = plot(G,'EdgeColor','g','NodeColor','k','LineStyle','-','LineWidth',4,'MarkerSize',5);

disp( 'All Costs')
for i=1:5
    disp([ ' The cost of Suggested Arcs ',num2str(i),'-',num2str(i+1),' is ', num2str(table(6,i))])
 end
disp( 'Which arcs do you want to connect?(Yes-->1 , No-->0) ')
for i=1:5
    disp([ ' The Suggested Arcs ',num2str(i),'-',num2str(i+1),'  Cost:', num2str(table(6,i))])
    M(i)=input('');
end
  
 

l=find(M==1);
u=size(l);
for i=1:u(2)
disp([ ' New Arcs ',num2str(i),'   ====>   ' , num2str(l(i)),' - ',num2str((l(i)+1))])
end
n=1;
m=1;
%% Group 1 and 2
G1=[];
G2=[];
for i=1:u(2)
if table(4,l(i))>=table(2,l(i))
G1(m)=l(i);
m=m+1;
else
G2(n)=l(i);
n=n+1;
end
end

G2sort=sort(G2);
G1sort=sort(G1,'descend');
K1=size(G2sort);
K2=size(G1sort);

disp(' Group 1 ');
for i=1:K2(2)
disp([num2str(G1sort(i)),' - ',num2str((G1sort(i)+1))])
end
disp(' Group 2 ');
for i=1:K1(2)
disp([num2str(G2sort(i)),' - ',num2str((G2sort(i)+1))])
end

for i=1:K1(2)
    G2sort(2,i)=G2sort(1,i)+1;
end
for i=1:K2(2)
    G1sort(2,i)=G1sort(1,i)+1;
end
P= cat(2, G1sort, G2sort);
result(1,:)=table(1,:);
for y=1:6
    i=y;
    for j=(K2(2)+K1(2)):-1:1
        
        if i~=P(1,j) && i~=P(2,j)
           N=i;
        elseif i~=P(1,j) && i==P(2,j)
           N=P(1,j);
        elseif   i==P(1,j) && i~=P(2,j)
           N=P(2,j);
        end
        i=N;
    end
        result(2,y)=table(5,i);
end
disp(' Best Schedule ');
for i=1:6
    z1=result(1,i);
    z2=result(2,i);
disp([num2str(z1),'--' , num2str(z2)]);
end


