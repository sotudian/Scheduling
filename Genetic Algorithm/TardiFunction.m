% SHAHAB SOTUDIAN-------94125091
function Tardiness=TardiFunction(x,JOBS_DATA)
    PT1=[JOBS_DATA.P1];
    PT2=[JOBS_DATA.P2];
    DT=[JOBS_DATA.D];
    n=length(PT1);
    G1=PT1(x);
    G2=PT2(x);
    G3=DT(x);
   T1(1)=G1(1);
   T2(1)=G1(1)+ G2(1);
        for i=2:n
        
        T1(i)=T1(i-1)+ G1(i);
        T2(i)=max(T2(i-1),T1(i))+ G2(i);
        
    end

   for i=1:1:10
    T(i)=max(T1(i)-G3(i),0);
   end
Tardiness=max(T);
    
    
end




