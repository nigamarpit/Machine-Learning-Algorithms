function Ques4_1_test()
urlwrite('https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data','4.data');
O=load('4.data');
R = O(randperm(size(O,1)),:);
%train data
A1=R(1:2300,1:57);
A2=R(1:2300,58);
%normalized train data
A1s=norm_data(A1);
%test data
B1=R(2301:size(R,1),1:57);
B2=R(2301:size(R,1),58);
%normalized test data
B1s=norm_data(B1);
nfeatures = size(A1,2);
w0 = zeros(nfeatures + 1, 1);
gdIter=1000;
newtonIter=50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% batch GD raw data
x_values = zeros(1,gdIter);
y_values = zeros(1,gdIter);
y2_values = zeros(1,gdIter);

w = w0;
precost = 0;
for j = 1:gdIter
    w = logisticRegressionWeights(A1, A2, w, 0.001);
    res = logisticRegressionClassify( A1, w );
    errors = abs(A2 - res);
    err = sum(errors);
    percentage1 = 1 - err / size(A1, 1);
    cost = CostFunc(A1, A2, w);
    if j~=0 && abs(cost - precost) / cost <= 0.00001
        break;
    end
    x_values(1,j)= j;
    y_values(1,j)= percentage1;
    precost=cost;
end
percentage1=y_values(1,gdIter);

%% batch GD normalised data
w = w0;
precost = 0;
for j = 1:gdIter
    w = logisticRegressionWeights(A1s, A2, w, 0.001);
    res = logisticRegressionClassify( A1s, w );
    errors = abs(A2 - res);
    err = sum(errors);
    percentage2 = 1 - err / size(A1s, 1);
    cost = CostFunc(A1s, A2, w);
    if j~=0 && abs(cost - precost) / cost <= 0.00001
        break;
    end
    x_values(1,j)= j;
    y2_values(1,j)= percentage2;
    precost=cost;
end
percentage2=y2_values(1,gdIter);

%% Newtons Method raw data
x_values = zeros(1,newtonIter);
y_values = zeros(1,newtonIter);
y2_values = zeros(1,newtonIter);

w = w0;
for j = 1:newtonIter
    w = Newton(A1, A2, w);
    res = logisticRegressionClassify( A1, w );
    errors = abs(A2 - res);
    err = sum(errors);
    percentage3 = 1 - err / size(A1, 1);
    x_values(1,j)= j;
    y_values(1,j)= percentage3;
end
percentage3=y_values(1,newtonIter);
%% Newtons Methos nomralized data
w = w0;
for j = 1:newtonIter
    w = Newton(A1s, A2, w);
    res = logisticRegressionClassify( A1s, w );
    errors = abs(A2 - res);
    err = sum(errors);
    percentage4 = 1 - err / size(A1s, 1);
    x_values(1,j)= j;
    y2_values(1,j)= percentage4;
end
percentage4=y2_values(1,newtonIter);
%% glmfit raw
G1 = glmfit(A1, A2, 'binomial','logit');
res = logisticRegressionClassify( A1, G1 );
errors = abs(A2 - res);
err = sum(errors);
percentage5 = 1 - err / size(A1, 1);
%% glmfit normalized
G2 = glmfit(A1s, A2, 'binomial','logit');
res = logisticRegressionClassify( A1s, G2 );
errors = abs(A2 - res);
err = sum(errors);
percentage6 = 1 - err / size(A1s, 1);
%% accuracies
disp(percentage1);
disp(percentage2);
disp(percentage3);
disp(percentage4);
disp(percentage5);
disp(percentage6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% batch GD raw data
x_values = zeros(1,gdIter);
y_values = zeros(1,gdIter);
y2_values = zeros(1,gdIter);

w = w0;
precost = 0;
for j = 1:gdIter
    w = logisticRegressionWeights(A1, A2, w, 0.001);
    res = logisticRegressionClassify( B1, w );
    errors = abs(B2 - res);
    err = sum(errors);
    percentage1 = 1 - err / size(A1, 1);
    cost = CostFunc(A1, A2, w);
    if j~=0 && abs(cost - precost) / cost <= 0.00001
        break;
    end
    x_values(1,j)= j;
    y_values(1,j)= percentage1;
    precost=cost;
end
percentage1=max(y_values);

%% batch GD normalised data
w = w0;
precost = 0;
for j = 1:gdIter
    w = logisticRegressionWeights(A1s, A2, w, 0.001);
    res = logisticRegressionClassify( B1s, w );
    errors = abs(B2 - res);
    err = sum(errors);
    percentage2 = 1 - err / size(A1s, 1);
    cost = CostFunc(A1s, A2, w);
    if j~=0 && abs(cost - precost) / cost <= 0.00001
        break;
    end
    x_values(1,j)= j;
    y2_values(1,j)= percentage2;
    precost=cost;
end
percentage2=max(y2_values);
subplot(1,2,1);
plot(x_values(1,:),y_values(1,:),x_values(1,:),y2_values(1,:));
title('Batch GD');
xlabel('iterations');
ylabel('accuracy');
legend('raw data','normalized data');

%% Newtons Method raw data
x_values = zeros(1,newtonIter);
y_values = zeros(1,newtonIter);
y2_values = zeros(1,newtonIter);

w = w0;
for j = 1:newtonIter
    w = Newton(A1, A2, w);
    res = logisticRegressionClassify( B1, w );
    errors = abs(B2 - res);
    err = sum(errors);
    percentage3 = 1 - err / size(A1, 1);
    x_values(1,j)= j;
    y_values(1,j)= percentage3;
end
percentage3=max(y_values);
%% Newtons Methos nomralized data
w = w0;
for j = 1:newtonIter
    w = Newton(A1s, A2, w);
    res = logisticRegressionClassify( B1s, w );
    errors = abs(B2 - res);
    err = sum(errors);
    percentage4 = 1 - err / size(A1s, 1);
    x_values(1,j)= j;
    y2_values(1,j)= percentage4;
end
percentage4=max(y2_values);
subplot(1,2,2);
plot(x_values(1,:),y_values(1,:),x_values(1,:),y2_values(1,:));
title('Newtons Method');
xlabel('iterations');
ylabel('accuracy');
legend('raw data','normalized data');
%% glmfit raw
G1 = glmfit(A1, A2, 'binomial','logit');
res = logisticRegressionClassify( B1, G1 );
errors = abs(B2 - res);
err = sum(errors);
percentage5 = 1 - err / size(A1, 1);
%% glmfit normalized
G2 = glmfit(A1s, A2, 'binomial','logit');
res = logisticRegressionClassify( B1s, G2 );
errors = abs(B2 - res);
err = sum(errors);
percentage6 = 1 - err / size(A1s, 1);
%% accuracies
disp(percentage1);
disp(percentage2);
disp(percentage3);
disp(percentage4);
disp(percentage5);
disp(percentage6);
%% Feature Analysis
p=convertBin(O(:,1:57),O(:,58));
P=zeros(57,10);
for i=1:size(p,2),
    pr=calculateProb(p{1,i});
    for j=1:10,
        P(i,j)=pr(j);
    end
    y=p{1,i};
end
figure;
plot(1:57,corr(O(:,1:57),O(:,58)));
title('PCC vs featureID');
xlabel('featureID');
ylabel('PCC');
end


function [w] = logisticRegressionWeights( XTrain, yTrain, w, learningRate)
    [nSamples, nFeature] = size(XTrain);
    temp = zeros(nFeature + 1,1);
    for k = 1:nSamples
        temp = temp + (sigmoid([1.0 XTrain(k,:)] * w) - yTrain(k)) * [1.0 XTrain(k,:)]';
    end
    w = w - learningRate * temp;

end

function [ res ] = logisticRegressionClassify( XTest, w )

    nTest = size(XTest,1);
    res = zeros(nTest,1);
    for i = 1:nTest
        sigm = sigmoid([1.0 XTest(i,:)] * w);
        if sigm >= 0.5
            res(i) = 1;
        else
            res(i) = 0;
        end
    end

end

function [ output ] = sigmoid( input )
    output = 1 / (1 + exp(- input));
end

function [ J ] = CostFunc( XTrain, yTrain, w )
    [nSamples, nFeature] = size(XTrain);
    temp = 0.0;
    for m = 1:nSamples
        hx = sigmoid([1.0 XTrain(m,:)] * w);
        if yTrain(m) == 1
            temp = temp + log(hx);
        else
            temp = temp + log(1 - hx);
        end
    end
    J = temp / (-nSamples);
end

function [M]=norm_data(N)
M=zeros(size(N));
[m,n]=size(N);
for i=1:n,
    mean_N=mean(N(:,i));
    std_N=std(N(:,i));
    for j=1:m,
        M(j,i)=(N(j,i)-mean_N)/std_N;
    end
end
end

function theta=Newton(x,y,theta)
[m,n]=size(x);
x = [ones(m, 1), x]; 
g = inline('1.0 ./ (1.0 + exp(-z))'); 
z = x * theta;
h = g(z);    
% Calculate gradient and hessian.
grad = (1/m).*x' * (h-y);
H = (1/m).*x' * diag(h) * diag(1-h) * x;    
% Calculate J (for testing convergence)
theta = theta - pinv(H)*grad;
end

function pf=calculateProb(y)
[g,~,gl] = grp2idx(y(:,1));
count = accumarray(g,1);
pf = count(g) ./ numel(g);
end