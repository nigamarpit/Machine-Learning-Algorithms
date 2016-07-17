function Ques4_2()
D=load('toyGMM.mat');
X_Tr=[D.dataTr.x1;D.dataTr.x2;D.dataTr.x3];
X_Te=[D.dataTe.x1;D.dataTe.x2;D.dataTe.x3];
Y_Tr=[ones(1000,1);ones(1000,1)*2;ones(1500,1)*3];
Y_Te=[ones(2500,1);ones(2500,1)*2;ones(3750,1)*3];
p1=1000/3500;
p2=1000/3500;
p3=1500/3500;
%% model 1 accuracy calculation
[m1,m2,m3,S1,S2,S3]=mnc(D.dataTr.x1,D.dataTr.x2,D.dataTr.x3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
%% model 2 accuracy calculation
clear sigma;
sigma=cov(X_Tr);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
disp(acc2);
disp(p1);
disp(p2);
disp(p3);
disp(m1);
disp(m2);
disp(m3);
disp(sigma);
%% model 3 accuracy calculation
[acc3,B]=Model3(X_Tr,Y_Tr,X_Te,Y_Te);
disp(acc3);
model3.w=B;
model3.w(:,3)=0;
%% part 4
model1.pi=[p1,p2,p3];
model1.m1=m1;
model1.m2=m2;
model1.m3=m3;
model1.S1=S1;
model1.S2=S2;
model1.S3=S3;
model2.pi=[p1,p2,p3];
model2.m1=m1;
model2.m2=m2;
model2.m3=m3;
model2.S=cov(X_Tr);
model2.S1=model2.S;
model2.S2=model2.S;
model2.S3=model2.S;
plotBoarder(model1, model2, model3, D.dataTe);
plotContour(X_Te,3);
%% part 5
accur=zeros(6,4);
accur(1,1)=1;
accur(2,1)=5;
accur(3,1)=10;
accur(4,1)=25;
accur(5,1)=50;
accur(6,1)=100;
%% 1%
R1=D.dataTr.x1(randperm(1000,10),:);
R2=D.dataTr.x2(randperm(1000,10),:);
R3=D.dataTr.x3(randperm(1500,15),:);
X1=[R1;R2;R3];
Y1=[ones(10,1);ones(10,1)*2;ones(15,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(1,2)=acc1;
accur(1,3)=acc2;
accur(1,4)=acc3;
%% 5%
R1=D.dataTr.x1(randperm(1000,50),:);
R2=D.dataTr.x2(randperm(1000,50),:);
R3=D.dataTr.x3(randperm(1500,75),:);
X1=[R1;R2;R3];
Y1=[ones(50,1);ones(50,1)*2;ones(75,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(2,2)=acc1;
accur(2,3)=acc2;
accur(2,4)=acc3;
%% 10%
R1=D.dataTr.x1(randperm(1000,100),:);
R2=D.dataTr.x2(randperm(1000,100),:);
R3=D.dataTr.x3(randperm(1500,150),:);
X1=[R1;R2;R3];
Y1=[ones(100,1);ones(100,1)*2;ones(150,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(3,2)=acc1;
accur(3,3)=acc2;
accur(3,4)=acc3;
%% 25%
R1=D.dataTr.x1(randperm(1000,250),:);
R2=D.dataTr.x2(randperm(1000,250),:);
R3=D.dataTr.x3(randperm(1500,375),:);
X1=[R1;R2;R3];
Y1=[ones(250,1);ones(250,1)*2;ones(375,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(4,2)=acc1;
accur(4,3)=acc2;
accur(4,4)=acc3;
%% 50%
R1=D.dataTr.x1(randperm(1000,500),:);
R2=D.dataTr.x2(randperm(1000,500),:);
R3=D.dataTr.x3(randperm(1500,750),:);
X1=[R1;R2;R3];
Y1=[ones(500,1);ones(500,1)*2;ones(750,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(5,2)=acc1;
accur(5,3)=acc2;
accur(5,4)=acc3;
%% 100%
R1=D.dataTr.x1(randperm(1000,1000),:);
R2=D.dataTr.x2(randperm(1000,1000),:);
R3=D.dataTr.x3(randperm(1500,1500),:);
X1=[R1;R2;R3];
Y1=[ones(1000,1);ones(1000,1)*2;ones(1500,1)*3];
[m1,m2,m3,S1,S2,S3]=mnc(R1,R2,R3);
mu=[m1;m2;m3];
sigma(:,:,1)=S1;
sigma(:,:,2)=S2;
sigma(:,:,3)=S3;
p=[p1;p2;p3];
acc1=Model1(mu,sigma,p,X_Te,Y_Te);
clear sigma;
sigma=cov(X1);
acc2=Model2(mu,sigma,p,X_Te,Y_Te);
[acc3,B]=Model3(X1,Y1,X_Te,Y_Te);
accur(6,2)=acc1;
accur(6,3)=acc2;
accur(6,4)=acc3;
%% plot accuracies
figure;
plot(accur(:,1),accur(:,2),accur(:,1),accur(:,3),accur(:,1),accur(:,4));
xlabel('Pecentage of random traning data');
ylabel('Accuracy in percentage');
title('Comparision of various GMM models');
legend('Model1 with independent covariances','Model2 with shared covariances','Mutlinomial Logistic Regression');
axis([0 100 80 100]);
end

function [acc]=Model1(mu,sigma,p,X_Te,Y_Te)
gm1 = gmdistribution(mu,sigma,p);
idx1=cluster(gm1,X_Te);
err1=Y_Te~=idx1;
err1=sum(err1);
percentage1 = 1 - err1 / 8750;
acc=percentage1*100;
end

function [acc]=Model2(mu,sigma,p,X_Te,Y_Te)
gm2 = gmdistribution(mu,sigma,p);
idx2=cluster(gm2,X_Te);
err2= Y_Te~=idx2;
err2=sum(err2);
percentage2 = 1 - err2 / 8750;
acc=percentage2*100;
end

function [acc,B]=Model3(X_Tr,Y_Tr,X_Te,Y_Te)
B=mnrfit(X_Tr,Y_Tr);
pihat=mnrval(B,X_Te);
res=zeros(8750,1);
for i=1:size(X_Te,1),
if max(pihat(i,:))==pihat(i,1)
res(i)=1;
elseif max(pihat(i,:))==pihat(i,2)
res(i)=2;
elseif max(pihat(i,:))==pihat(i,3),
res(i)=3;
end
end
v=res==Y_Te;
acc=sum(v)/8750*100;
end

function[m1,m2,m3,S1,S2,S3]= mnc(x1,x2,x3)
m1=mean(x1);
m2=mean(x2);
m3=mean(x3);
S1=cov(x1);
S2=cov(x2);
S3=cov(x3);
end