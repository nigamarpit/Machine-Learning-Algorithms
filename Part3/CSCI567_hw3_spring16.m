function CSCI567_hw3_spring16()
format short
train=importdata('diabetic-train.mat');
test=importdata('diabetic-test.mat');
x_train=normalize(train.x,test.x);
x_test=normalize(test.x,train.x);
train.y=scaleY(train.y);
test.y=scaleY(test.y);


%% 5.3.a
C=ques53a(x_train,train.y);
[w,b]=trainsvm(x_train,train.y,C);
accu = testsvm(x_test, test.y, w, b);
disp(['Test Accuracy with selected value of C from cross validation==', num2str(accu*100)]);
%% 5.3.b
disp('ques 5.3.b')
disp(['Value of C based on cross validation = ',num2str(C),' or C=4^2'])
%% 5.3.c
accu2 = own_linear( x_train, train.y, x_test, test.y, C);
disp('ques 5.3.c')
disp(['Test Accuracy through own_linear= ', num2str(accu2*100)]);
%% 5.4.a
disp('ques 5.4.a');
[c,avg_accu,avg_time] = ques54a(x_train,train.y)
%% 5.5.a
disp('ques 5.5.a')
[acc55a,time55a]=ques55a(x_train, train.y)
%% 5.5.b
disp('ques 5.5.b')
[acc55b,time55b]=ques55b(x_train, train.y)
d = distMetric_new(x_train)
disp('Using libSVM')
libSVM(x_train, train.y, x_test, test.y)

%% Question 6
ques6();

function x_norm=normalize(x,y)
z=[x;y];
for n=1:19,
ma=max(z(:,n));
mi=min(z(:,n));
x_norm(:,n)=(x(:,n)-mi)/(ma-mi);
end

function y=scaleY(y)
y(y==0)=-1;
