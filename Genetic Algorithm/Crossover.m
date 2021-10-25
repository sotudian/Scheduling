% SHAHAB SOTUDIAN-------94125091
function  CrossP=crossover(CrossP,population,Num_Var,JOBS_DATA,Num_Cross)
h=[population.fit];
h=1./h;
h=h./sum(h);
h=cumsum(h);
for n=1:2:Num_Cross
    i1=find(rand<=h,1,'first');
    i2=find(rand<=h,1,'first');
p1=population(i1).x;
p2=population(i2).x;

j=randi([1 Num_Var-1]);

A1=[p1(1:j) p2(j+1:end)];
A2=[p2(1:j) p1(j+1:end)];

A1=unique([A1 randperm(Num_Var)],'stable');
A2=unique([A2 randperm(Num_Var)],'stable');
CrossP(n).x=A1;
CrossP(n).fit=TardiFunction(CrossP(n).x,JOBS_DATA);
CrossP(n+1).x=A2;
CrossP(n+1).fit=TardiFunction(CrossP(n+1).x,JOBS_DATA);
end
end



















