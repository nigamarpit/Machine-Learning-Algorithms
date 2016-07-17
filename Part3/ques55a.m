function [acc,time]=ques55a(train_X, train_Y)

c = [4^-3, 4^-2, 4^-1, 1, 4, 4^2, 4^3, 4^4, 4^5, 4^6, 4^7];
deg = [1,2,3];
avg_accuracy = zeros(length(c(1,:)), length(deg(1,:)));
avg_time = zeros(length(c(1,:)), length(deg(1,:)));
ksize = 3;

for i = 1:length(c(1,:))
    t = cputime;
    
    for j = 1:length(deg(1,:))
        p = ['-t 1 -q -c ',num2str(c(i)), ' -v ',num2str(ksize), '-d', num2str(deg(j))];
        avg_accuracy(i,j) = svmtrain(double(train_Y), double(train_X), p);
    
        e = cputime - t;
        avg_time(i,j) = e/ksize;   
    end   
end

acc = [[{'Avg.accuracy'}, num2cell(deg)];num2cell([c',avg_accuracy])];
time = [[{'Avg.time'}, num2cell(deg)];num2cell([c',avg_time])];
end