function [acc,time]=ques55b(train_X, train_Y)

c = [4^-3, 4^-2, 4^-1, 1, 4, 4^2, 4^3, 4^4, 4^5, 4^6, 4^7];
gamma = [4^-7, 4^-6, 4^-5, 4^-4, 4^-3, 4^-2, 4^-1, 1, 4, 4^2];
avg_accu = zeros(length(c(1,:)), length(gamma(1,:)));
avg_time = zeros(length(c(1,:)), length(gamma(1,:)));
k = 3;

for i = 1:length(c(1,:))
    t = cputime;
    
    for j = 1:length(gamma(1,:))
        p = ['-t 2 -q -c ',num2str(c(i)), ' -v ',num2str(k), '-g', num2str(gamma(j))];
        avg_accu(i,j) = svmtrain(double(train_Y), double(train_X), p);
    
        e = cputime - t;
        avg_time(i,j) = e/k;   
    end   
end

acc = [[{'Avg.accuracy'}, num2cell(gamma)];num2cell([c',avg_accu])];
time = [[{'Avg.time'}, num2cell(gamma)];num2cell([c',avg_time])];
end