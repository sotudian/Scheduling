clear
clc;

load ('Data.mat');
table=[];
z=JobsData;
t=JobsData;
i=1;
% fi sorting
while i<=15
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

for i=1:15
    w=find(b(1,:)==eQ(1,i));
    table(5,i)=table(1,w(1));
    b(1,w(1))=1000;
    
end

for i=1:14
q=min(table(2,i+1),table(4,i+1))-max(table(2,i),table(4,i));
C(i)=max(0,q);
end
C(i+1)=1000000;
table(6,:)=C;

table
