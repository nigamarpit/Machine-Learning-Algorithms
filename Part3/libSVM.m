function libSVM( train_X, train_Y, test_X, test_Y )
C = [4^-6,4^-5,4^-4,4^-3,4^-2,4^-1,1,4,4^2];
accuracy = zeros(length(C),1);
time = zeros(length(C),1);
for j=1:length(C)
    startTime = tic;
    p = ['-q -s 0 -t 0 -v 5 -c',' ',num2str(C(j))];
    accu = svmtrain(train_Y,train_X,p);
    endTime = toc(startTime);
    accuracy(j) = accu;
    time(j) = endTime;
end

[Y I] = max(accuracy);
coef = C(I);

disp(['C = ',num2str(coef),' Max Accuracy = ',num2str(Y),' Execution Time = ',num2str(time(I))]);

p = ['-q -s 0 -t 0 -c',' ',num2str(coef)];
model = svmtrain(train_Y,train_X,p);
result = svmpredict(test_Y,test_X,model);
test_accuracy = sum(result==test_Y)/length(test_Y);
disp(['Test Accuracy using C = ',num2str(coef),' is ',num2str(test_accuracy*100)]);
end
