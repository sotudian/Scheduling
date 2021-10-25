% SHAHAB SOTUDIAN-------94125091
function [result]=TardiFunction(TOTAL)
T1(1)=TOTAL(1,1);
T2(1)=TOTAL(1,1)+ TOTAL(2,1);
for i=2:1:10
T1(i)=T1(i-1)+ TOTAL(1,i);
T2(i)=max(T2(i-1),T1(i))+ TOTAL(2,i);
end
for i=1:1:10
    T(i)=max(T1(i)-TOTAL(3,i),0);
end
result=max(T);