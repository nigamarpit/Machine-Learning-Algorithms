function CSCI567_hw5_spring16()
clear
clc
X=load('x_train.mat');
Y=load('y_train.mat');
x_train=X.x_train;
y_train=Y.y_train;
clear X
clear Y
X=load('x_test.mat');
Y=load('y_test.mat');
x_test=X.x_test;
y_test=Y.y_test;

n = size(x_train,1);
meanval = nanmean(x_train);
meanmat = repmat(meanval,n,1);
x_trainm = (x_train - meanmat);
[ntest,dtest] = size(x_test);
meanmattest = repmat(meanval,ntest,1);
x_testm = (x_test - meanmattest);
%% Part a
eigenvecs = get_sorted_eigenvecs(x_trainm);
%% Part b
Partb(eigenvecs);
%% Part c
Partc(eigenvecs,x_trainm);
%% Part d
Partd(eigenvecs, x_trainm, x_testm, y_train, y_test);
end

%%
function Partb(eigenvecs)
figure(1);
c = 8;
for i = 1:c
    subplot(2,4,i)
    imshow(double(reshape(eigenvecs(:,i),16,16)),[])
    title(i)
end
end
%%
function Partc(eigenvecs, x_trainm)
figure(2);
S = [250,300,450,500,3000];
k = [1,3,5,15,100];

for i = 1:length(S)
    subplot(length(k)+1,length(S),i)
    imshow(double(reshape(x_trainm(S(i),:),16,16)),[])
    title(['raw image #',num2str(S(i))])    
    p = length(S)+i;
    for j = 1:length(k)
        eigen_subset = eigenvecs(:,1:k(j));
        x_compressed = x_trainm*eigen_subset;
        reconstruct = x_compressed*eigen_subset';
        subplot(length(k)+1,length(S),p)   
        imshow(double(reshape(reconstruct(S(i),:),16,16)),[])
        title(['s#',num2str(S(i)),', #pc=',num2str(k(j))])
        p = p+length(S);
    end  
end
end
%%
function Partd( eigenvecs, x_trainm, x_testm, y_train, y_test )

k = [1,3,5,15,100];

train_accuracy = zeros(1,length(k));
test_accuracy = zeros(1,length(k));
runtime = zeros(1,length(k));

for i = 1:length(k)
    t = cputime;
    
    eigen_subset = eigenvecs(:,1:k(i));
    x_train_compressed = x_trainm*eigen_subset;
    x_train_reconstruction = x_train_compressed*eigen_subset';
    x_test_compressed = x_testm*eigen_subset;
    x_test_reconstruction = x_test_compressed*eigen_subset';
    
    tree = fitctree(x_train_reconstruction, y_train, 'SplitCriterion', 'deviance');
    train_label_inferred = predict(tree, x_train_reconstruction);
    test_label_inferred = predict(tree, x_test_reconstruction);
    
    train_accuracy(i) = sum(train_label_inferred==y_train)*100/length(y_train(:,1));
    test_accuracy(i) = sum(test_label_inferred==y_test)*100/length(y_test(:,1));
    runtime(i) = cputime-t;
end
output = [{'K', 'Train Accuracy', 'Test Accuracy', 'Runtime'}; num2cell([k',train_accuracy',test_accuracy',runtime'])]
end