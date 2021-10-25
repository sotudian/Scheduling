clear
clc
%  Shahab Sotudian--94125091-scheduling
% Johnson's algorithm 
disp('We have 10 Jobs snd 2 machines')
disp('****please enter the processing times for machine 1 ****')
for tt=1:10
  fprintf('Enter the amount of  processing times for job %d (machine 1)',tt);  
  m1(tt)=input('');  
end
  
disp('*************************************************************')
disp('****please enter the processing times for machine 2 ****')
for rr=1:10
  fprintf('Enter the amount of  processing times for job %d (machine 2)',rr);  
  m2(rr)=input('');  
end
j=1;
a=m1;
b=m2;
k=1;
l=10;
w=0;
ss=1;
nn=1;
other1=[];
other2=[];
schedule=zeros(1,10);
unschedulejob=10;

while unschedulejob>0

    p=min(min(a));
    m=min(min(b));
    if (p>1000) && (1000<m)
        break
    end
     g=find(a==p);
     h=find(b==m);
    sizeofp=size(g,2);
    sizeofm=size(h,2);
    
   %***************************************** 
    if (sizeofp==1) && (sizeofm==1)
        if  (p<m) 
          g=find(a==p);
         schedule(k)=g;
         a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
      elseif (p>m) 
          h=find(b==m);
         schedule(l)=h; 
         a(h)=a(h)+1000;
         b(h)=b(h)+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;
      elseif  p==m 
          h=find(b==m);
           g=find(a==p);
           
          if g==h
           schedule(k)=g;
         a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
          else
             schedule(k)=g;
         a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1; 
            schedule(l)=h; 
         a(h)=a(h)+1000;
         b(h)=b(h)+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;  
          end
           
         
      end
        %*****************************************  
        elseif (sizeofp>1) && (sizeofm==1)
         if  (p(1)<m) 
          g=find(a==p);
          w=size(g,2);
          for i=1:w
         schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
         b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
         other1(ss,i)=g(i);
          end
          ss=ss+1;
      elseif (p(1)>m) 
          h=find(b==m);
         schedule(l)=h; 
         a(h)=a(h)+1000;
         b(h)=b(h)+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;
      elseif  p(1)==m 
          h=find(b==m);
           g=find(a==p);
           w=size(g,2);
           ee=0;
             for i=1:w
                 
              other1(ss,i)=g(i);   
          if g(i)==h
           schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
          b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
                   else
             schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
          b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1; 
         if ee==0
            schedule(l)=h; 
            ee=ee+1;
            a(h)=a(h)+1000;
         b(h)=b(h)+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1; 
         end
          
          end
           
          end
          ss=ss+1;
         
      end
            %***************************************** 
            elseif (sizeofp==1) && (sizeofm>1)
         if  (p<m(1)) 
          g=find(a==p);
         schedule(k)=g;
         a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
      elseif (p>m(1)) 
          h=find(b==m(1));
          s=size(h,2);
          for i=1:s
         schedule(l)=h(i); 
         a(h(i))=a(h(i))+1000;
         b(h(i))=b(h(i))+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;
          other2(nn,i)=h(i);
          end
          nn=nn+1;
      elseif  p==m(1) 
          h=find(b==m);
           g=find(a==p);
             s=size(h,2);
             ee=0;
        for i=1:s 
            other2(nn,i)=h(i);
          if g==h(i)
           schedule(k)=g;
         a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
          else
                       if ee==0
                     schedule(k)=g;
                     ee=ee+1;
                     a(g)=a(g)+1000;
          b(g)=b(g)+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
                       end
             
          
            schedule(l)=h(i); 
         a(h(i))=a(h(i))+1000;
         b(h(i))=b(h(i))+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;  
          end
        end 
           nn=nn+1;
         
      end       
                
                
                %***************************************** 
                elseif (sizeofp>1) && (sizeofm>1)
   w=size(g,2);
  s=size(h,2);
for i=1:w
   other1(ss,i)=g(i);
end
ss=ss+1;
for j=1:s
    other2(nn,j)=h(j);
end                
                    
                    
         if  (p(1)<m(1)) 
          g=find(a==p);
          w=size(g,2);
          for i=1:w
         schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
         b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
          
          end
          
      elseif (p(1)>m(1)) 
          h=find(b==m(1));
          s=size(h,2);
          for i=1:s
         schedule(l)=h(i); 
         a(h(i))=a(h(i))+1000;
         b(h(i))=b(h(i))+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;
          
          end
          
      elseif  p(1)==m(1) 
          h=find(b==m);
           g=find(a==p);
            w=size(g,2);
             s=size(h,2);
             
           for i=1:w
               for j=1:s
if (a(g(i))>1000) || (1000<b(h(j)))
        continue;
            end                   
if g(i)==h(j)
           schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
          b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1;
         break;
          else
              
             schedule(k)=g(i);
         a(g(i))=a(g(i))+1000;
          b(g(i))=b(g(i))+1000;
         unschedulejob=unschedulejob-1;
         k=k+1; 
            schedule(l)=h(j); 
         a(h(j))=a(h(j))+1000;
         b(h(j))=b(h(j))+1000;         
         unschedulejob=unschedulejob-1;
         l=l-1;  
          end
               end
           end
        
      end
        
        
        
    end
        
            
end
    disp('*** Optimal scheduling ***')
    schedule
    disp('**************************************************')
    
    disp('*** Permutations of these has the same results ***')
        machine1=other1;
           machine2=other2;
           machine1
           machine2
    
    %Guntt chart
    
    e1=min(m1(schedule(1)),m2(schedule(1)));
    if m1(schedule(1))==e1
        d1=m1(schedule(1));
       d2=0;
    else
        d2=m2(schedule(1));
       d1=0;
    end
    
   
    
    y = [ (d2) m1(schedule(1))  m1(schedule(2))  m1(schedule(3))  m1(schedule(4))  m1(schedule(5))  m1(schedule(6))  m1(schedule(7)) m1(schedule(8)) m1(schedule(9)) m1(schedule(10));
        (d1) m2(schedule(1))  m2(schedule(2))  m2(schedule(3))  m2(schedule(4))  m2(schedule(5))  m2(schedule(6))  m2(schedule(7)) m2(schedule(8)) m2(schedule(9)) m2(schedule(10))];
figure;
barh(y,'stacked','LineWidth',1)
title('Guntt Chart')
ylabel('Machines');
xlabel('Time');
legend('Waiting Time');

 
 