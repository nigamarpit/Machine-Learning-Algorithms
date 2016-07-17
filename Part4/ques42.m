function ques42()
format short;
warning off;
models=5; %% number of models
k=[3,5,7,9,11];
input=load('emGMM.mat');
x=input.dataTr;
tr=zeros(5,5);
val=zeros(5,5);
iterations=zeros(5,5);
for j=1:length(k)
for i = 1:models
    [mu_init,sigma_init,pi_init] = initilization(x,k(j));
    [mu,sigma,pi,iter] = EM_GM(x,mu_init,sigma_init,pi_init,k(j),i);
    [a,b]=marginals(input.dataTr,input.dataVal,mu,sigma{2},pi);
    disp(strcat('For k=',num2str(k(j)),' and model#',num2str(i),'==> #iterations=',num2str(iter),'; train loglikelihood=',num2str(a),'; val loglikelihood=',num2str(b)));
    iterations(j,i)=iter;    
    tr(j,i)=a;
    val(j,i)=b;
end
end
best_calculations(tr,val,iterations,k);
input('Press any key for ques 4.3');
end
%%
function [mu,sigma,pi]= initilization(input,k)
rows=size(input,1);
centeroid_idx = datasample(1:rows,k,'Replace',false);
centeroid_idx = sort(centeroid_idx);
mu = input(centeroid_idx,:);
overall_convariance = cov(input);
for j = 1:k
    sigma{j} = overall_convariance/k;
end
pi=zeros(1,k);
x=rand(1,k);
s=sum(x);
pi=x/s;
end
%%
function [new_mu,new_sigma,pi,iter]=EM_GM(x,mu,sigma,pi,k,i)
flag = true;
MaxIteration = 10000;
logpiThreshold = 10e-9;
logpiThresNew = 0;
logpiThresOld = 0;
iter = 0;
log_p_self=[];

    log_p= ComputeLogLiklihood(x,mu,sigma,pi);
    logpiThresNew = log_p;
    log_p_self=[log_p_self log_p];

sigma1 = sigma;
mu1 = mu;
while flag
    iter = iter+1;
    i=iter;
    logpiThresOld = logpiThresNew;    
    P = E_Step(x,pi,mu1,sigma1);    
    meanss_1=mu1;
    [mu1,sigma1,pi,log_p]=M_Step(P,x,meanss_1);   
    logpiThresNew = log_p;
    log_p_self=[log_p_self log_p];
    val = abs((logpiThresNew - logpiThresOld)/logpiThresOld);
    if(iter >= MaxIteration || val<logpiThreshold)
        flag = false;
    end  
end
new_mu = mu1;
new_sigma = {sigma,sigma1};
new_P = P;
end
%%
function log_p = ComputeLogLiklihood(x,mu,sigma,pi)
sum_prr=0;
sizeX = size(x,1);
noOfClusters = size(mu,1);
for i = 1:sizeX
    X = x(i,:);
    sum_trr=0;
    for j=1:noOfClusters        
        M = mu(j,:);
        SIGMA = sigma{j};        
        sum_trr = sum_trr + pi(j)* myPDF2D(X,M,SIGMA);
    end
    sum_prr = sum_prr + log(sum_trr);
end
log_p = sum_prr;
end
%%
function p= myPDF2D(X,M,SIGMA)
d=2;
p = (((((2*pi)^(d))*det(SIGMA))^(-(1/2)))   *  exp((-1/2)*(X-M) * inv(SIGMA) * (X-M)'));
end
%%
function [P,log_p] = E_Step(x,pi,mu,sigma)
noOfClusters = size(pi,2);
sizeX = size(x,1);
P(1:sizeX,1:noOfClusters)=0;
for i = 1:sizeX
    sum_dm=0;
    X = x(i,:);
    for j = 1:noOfClusters        
        M = mu(j,:);
        SIGMA = sigma{j};
        tmp = pi(j) * myPDF2D(X,M,SIGMA);
        P(i,j) = tmp;   
        sum_dm=sum_dm + tmp;
    end
    for j = 1:noOfClusters
        P(i,j)= P(i,j)/ sum_dm;
    end    
end
end
%%
function [new_mu,covs,pi,log_p]=M_Step(P,x,mu)
k = size(P,2);
sizeX =  size(x,1);
new_mu(1:k,1:2) = 0;
sum_d(1:k)=0;
for i=1: sizeX
    sum_d = sum_d + P(i,:);
end
for j=1:k
    sum_n(1:2)=0;    
    for i=1:sizeX
        sum_n= sum_n + P(i,j)*x(i,:);
    end
    new_mu(j,:) = sum_n/sum_d(j);
end
for j = 1:k
    sum_n(1:2,1:2) = 0;
    sum_d = 0;    
    for i=1:sizeX
        sum_d = sum_d + P(i,j);
        sum_n = sum_n + P(i,j)*((x(i,:)-mu(j,:))'*(x(i,:)-mu(j,:)));
    end
    covs{j} = sum_n /sum_d ;
end
pi(1:k) =0; 
    for i=1:sizeX
        pi = pi + P(i,:);
    end
    pi = pi/sizeX;
log_p= ComputeLogLiklihood(x,new_mu,covs,pi);
end
%%
function [tr_llh,val_llh]=marginals(train,val,mu,sigma,pi)
tr_llh=ComputeLogLiklihood(train,mu,sigma,pi);
%disp(tr_llh);
val_llh=ComputeLogLiklihood(val,mu,sigma,pi);
%disp(val_llh);
end
%%
function best_calculations(tr,val,iterations,k)
disp('Best==>');
for i=1:length(k)
    [m,j]=max(val(i,:));    
    disp(strcat('For k=',num2str(k(i)),' #iterations=',num2str(iterations(i,j)),'; train marginal log likelihood=',num2str(tr(i,j)),'; val marginal log likelihood=',num2str(m)));
end
end