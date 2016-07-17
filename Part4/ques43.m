function ques43()

input = imread('hw4.jpg');
K=[4,8,24];
for i = 1:length(K)
    %i
    %K(i)
    %size(input)
    vec = convert1D(input);
    %size(vec)
    idx = kmeans(vec,K(i));
    %disp(size(idx));
    VecQ = vecQuatize(vec,idx,K(i));
    newImage = convert2D(VecQ,input);
    figure();
    image(newImage);
    t=strcat('K=',num2str(K(i)));
    title(t); 
end
end
%%
function vecQ = vecQuatize(vec,idx,k)    
    for i=1:k
       if(sum(idx==i)>0)
           m1 = mean(vec(idx==i,1));
           m2 = mean(vec(idx==i,2));
           m3 = mean(vec(idx==i,3));
           vec(idx==i,1) = m1;
           vec(idx==i,2) = m2;
           vec(idx==i,3) = m3;
       end
    end
    vecQ = vec;
end
%%
function vec = convert1D(input)
    vec = zeros(size(input,1)*size(input,2),3);
    c = 1;
    for i = 1:size(input,1)
        for j = 1:size(input,2);
           for k = 1:3
               vec(c,k) = input(i,j,k);
           end
           c = c+1;
        end
    end
end
%%
function [input] = convert2D(vecQ,input)
    m = 0;    
    n = 0;    
    for i = 1:size(vecQ,1)        
        if n==0
            n=1;
            m=m+1;
        end        
        for k = 1:3
            input(m,n,k) = vecQ(i,k);
        end        
        n = mod((n+1),size(input,2)+1);
    end
end