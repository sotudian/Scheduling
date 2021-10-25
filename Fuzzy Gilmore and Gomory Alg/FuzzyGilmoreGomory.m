clear
clc;
% SHAHAB SOTUDIAN-------94125091
% SCHEDULING ASSIGNMENT----Fuzzy Gilmore and Gomory Alg
% 8 Jobs
% 2 Machines
load ('Data.mat');
table=[];
z=JobsData;
t=JobsData;
i=1;
% fi sorting
SIGMAm1=JobsData(3,:);
MEANm1=JobsData(2,:);
SIGMAm2=JobsData(5,:);
MEANm2=JobsData(4,:);
x1=cell(8,1);
y1=cell(8,1);
x2=cell(8,1);
y2=cell(8,1);
%% Gaussian membership function Processing time machine 1
for i=1:1:8
 x1{i}=0:0.1:20;
 y1{i}= gaussmf(x1{i},[SIGMAm1(i) MEANm1(i)]);
end
%% Gaussian membership function Processing time machine 2
for i=1:1:8
 x2{i}=0:0.1:20;
 y2{i}= gaussmf(x2{i},[SIGMAm2(i) MEANm2(i)]);
 end

% we havent similar PT 
for i=1:1:8
   s=find(t(4,:)==min(t(4,:)));
   z(:,i)=t(:,s);
   t(:,s)=1000;
end

% eQ
t2=JobsData;
eQ=t2(1:2,:);
for i=1:1:8
   s=find(t2(2,:)==min(t2(2,:)));
   eQ(:,i)=t2(2:3,s);
   t2(:,s)=1000;
end


table(1,:)=JobsData(1,:); 
table(2,:)=z(4,:);  
table(3,:)=z(5,:); 
table(4,:)=z(2,:);
table(5,:)=z(3,:);
table(6,:)=eQ(1,:);
table(7,:)=eQ(2,:);

b=table(4:5,:);
for i=1:8
    w=find(b(1,:)==eQ(1,i));
    table(8,i)=table(1,w(1));
    b(:,w(1))=1000;
end

  %% ************ COST
for m=1:7
  
% MAX 
sigma1=table(3,m);
mean1=table(2,m);
sigma2=table(7,m);
mean2=table(6,m);
alfa=0;
y=[];
for i=1:1:101
    alfa=(i-1)/100;
   y(i)=alfa;
smax1(i)=max((mean1-sigma1*sqrt((-2)*log(alfa))),(mean2-sigma2*sqrt((-2)*log(alfa))));
smax2(i)=max((mean1+sigma1*sqrt((-2)*log(alfa))),(mean2+sigma2*sqrt((-2)*log(alfa))));
end
 smax2=sort(smax2);
 smax2(1)=[];
 Lmax(m,:)=cat(2,smax1,smax2);
 


 %% MIN
Sigma1=table(3,m+1);
Mean1=table(2,m+1);
Sigma2=table(7,m+1);
Mean2=table(6,m+1);
 alfa=0;
yy=[];
for i=1:1:101
    alfa=(i-1)/100;
   yy(i)=alfa;
smin1(i)=min((Mean1-Sigma1*sqrt((-2)*log(alfa))),(Mean2-Sigma2*sqrt((-2)*log(alfa))));
smin2(i)=min((Mean1+Sigma1*sqrt((-2)*log(alfa))),(Mean2+Sigma2*sqrt((-2)*log(alfa))));
end  
smin2=sort(smin2);
 smin2(1)=[];
 Lmin(m,:)=cat(2,smin1,smin2);  
 
 %% Subtraction
 
  for i=1:100
SIGLmin(m,i)=(Lmin(m,i)- Lmin(m,101))/sqrt(-2*log(yy(i)));
  end
  vv=SIGLmin(m,5:55);
sigmaLmin=abs(mean(vv));

for i=1:100
SIGLmax(m,i)=(Lmax(m,i)- Lmax(m,101))/sqrt(-2*log(yy(i)));
  end
  aa=SIGLmax(m,5:55);
sigmaLmax=abs(mean(aa));


for i=1:1:101
    alfa=(i-1)/100;
   y(i)=alfa;
s1(i)=(Lmin(m,101)-sigmaLmin*sqrt((-2)*log(alfa)))-(Lmax(m,101)+sigmaLmax*sqrt((-2)*log(alfa)));
s2(i)=(Lmin(m,101)+sigmaLmin*sqrt((-2)*log(alfa)))-(Lmax(m,101)-sigmaLmax*sqrt((-2)*log(alfa)));
end
s2=sort(s2);
 s2(1)=[];
 Q(m,:)=cat(2,s1,s2);  
     
 C(m)=max(0,Q(m,101));
end
C(m+1)=1000000;

 table(9,:)=C;

%% New arcs
for i=1:8
 SS(1,i)=table(1,i);
SS(2,i)=table(8,i);
end

disp( ' initial  Graph')
for i=1:8
    disp([ ' Arc ',num2str(i),'   ====>   ' , num2str(SS(1,i)),' - ',num2str(SS(2,i))])
end

%  G=digraph(SS(1,:),SS(2,:),'OmitSelfLoops');
% p = plot(G,'EdgeColor','g','NodeColor','k','LineStyle','-','LineWidth',4,'MarkerSize',5);


disp( 'All Costs')
for i=1:7
    disp([ ' The cost of Suggested Arcs ',num2str(i),'-',num2str(i+1),' is ', num2str(C(i))])
 end
disp( 'Which arcs do you want to connect?(Yes-->1 , No-->0) ')
for i=1:7
    disp([ ' The Suggested Arcs ',num2str(i),'-',num2str(i+1),'  Cost:', num2str(C(i))])
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
if table(6,l(i))>=table(2,l(i))
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
for y=1:8
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
        result(2,y)=table(8,i);
end
disp(' Best Schedule ');
for i=1:8
    z1=result(1,i);
    z2=result(2,i);
disp([num2str(z1),'--' , num2str(z2)]);
end

%% plotting PT in M1 & M2
for i=1:8
   
subplot(4,4,i)
plot(x1{i},y1{i},'b','LineWidth',2)
hold on
plot(x2{i},y2{i},'r','LineWidth',2)
title(['Processing Time -- Job',num2str(i)]);
legend('M1','M2');

end


xx=fliplr(yy);
xx(1)=[];
cc=cat(2,yy,xx);
for i=1:7
 subplot(4,4,i+8)
p1=plot(Q(i,:),cc,'k','LineWidth',2,'MarkerEdgeColor','b');
grid
axis tight
hold on
title(['Cost of ARC ',num2str(i),'-',num2str(i+1),'     center = ',num2str(Q(i,101))]);
end