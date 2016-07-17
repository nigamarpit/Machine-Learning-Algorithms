function ques41()
file1=load('hw4_blob.mat');
input1=file1.data2;
file2=load('hw4_circle.mat');
input2=file2.points;
disp('Ques 4.1');
disp('Blob Plot');
calculations(input1);
input('Press any key for circle plot');
calculations(input2);
input('Press any key for ques 4.2');
end

function calculations(input)
K=[2,3,5];
[m,n]=size(input);
final=zeros(length(K),m);
for i=1:length(K)
    init_mean=rand(K(i),n);
    p=zeros(m,1);
    c=[];
    while(~isequal(c,p))
        p=c;
        um=zeros(m,K(i));
        dist=pdist2(input,init_mean);
        [~,I]=min(dist,[],2);
        c=I;
        for l=1:m
            um(l,I(l))=1;
        end
        for j=1:K(i)
            init_mean(j,:)=(um(:,j)'*input)/sum(um(:,j));
        end
        init_mean(isnan(init_mean))=rand(1,1);
        if(isequal(p,c))
            final(i,:)=I';
        end
    end
end
figure();
subplot(2,2,1)
scatter(input(:,1),input(:,2),[],final(1,:))
subplot(2,2,2)
scatter(input(:,1),input(:,2),[],final(2,:))
subplot(2,2,3)
scatter(input(:,1),input(:,2),[],final(3,:))
end