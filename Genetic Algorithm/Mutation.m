% SHAHAB SOTUDIAN-------94125091
function  MutationPop=mutation(MutationPop,population,Num_Var,JOBS_DATA,Num_Mutation,populationsize)
for n=1:Num_Mutation
   i=randi([1 populationsize]);  
   p=population(i).x;
W1=randi([1 Num_Var-1]);
W2=randi([W1+1 Num_Var]);
nW1=p(W1);
nW2=p(W2);
p(W1)=nW2;
p(W2)=nW1;
MutationPop(n).x=p;
MutationPop(n).fit=TardiFunction(MutationPop(n).x,JOBS_DATA);

end
end