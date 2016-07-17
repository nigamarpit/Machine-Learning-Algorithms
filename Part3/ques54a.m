function [c,avg_accuracy,avg_time] = ques54a(train_X,train_Y)

c = [4^-6, 4^-5, 4^-4, 4^-3, 4^-2, 4^-1, 1, 4, 4^2];
avg_accuracy = zeros(1,length(c(1,:)));
avg_time = zeros(1,length(c(1,:)));
k = 3;

    for i = 1:length(c(1,:))
        t = cputime;

        p = ['-t 2 -q -c ',num2str(c(i)), ' -v ',num2str(k)];
        avg_accuracy(i) = svmtrain(double(train_Y), double(train_X), p);

        e = cputime - t;
        avg_time(i) = e/k; 
    end    
end