function [c_max] = ques53a(X, Y)

c = [4^-6, 4^-5, 4^-4, 4^-3, 4^-2, 4^-1, 1, 4, 4^2];
avg_accuracy = zeros(1,length(c(1,:)));
avg_time = zeros(1,length(c(1,:)));
ksize = 3;
Z=[X Y];
Z=Z(randperm(size(Z,1)),:);

X=Z(:,1:19);
Y=Z(:,20);
n = length(X);
cvindex = [1, floor(n/ksize) , floor(2 * n/ksize), n];

for i = 1:length(c(1,:))
    accu=0;
    t = cputime;
     
    for j = 1:ksize
        temp_train_X = X;  
        temp_Y = Y;
        
        temp_test_X = temp_train_X(cvindex(j):(cvindex(j+1)-1),:);
        temp_train_X(cvindex(j):(cvindex(j+1)-1),:) = [];
        
        temp_test_Y = temp_Y(cvindex(j):(cvindex(j+1)-1));       
        temp_Y(cvindex(j):(cvindex(j+1)-1)) = [];
        
        [temp_w, temp_b] = trainsvm(temp_train_X, temp_Y, c(i));
        accu =accu+ testsvm(temp_test_X, temp_test_Y, temp_w, temp_b);
    end

    e = cputime - t;
    avg_accuracy(i)=accu/ksize;
    avg_time(i) = e/ksize; 
end
clc
disp 'ques 5.3.a Cross Validation'
c
avg_accuracy
avg_time
c_max = c(find(max(avg_accuracy)==avg_accuracy));

%output = [{'C', 'Average Accuracy', 'Average Time'};num2cell(output)]
end