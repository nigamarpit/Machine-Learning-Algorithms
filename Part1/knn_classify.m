function knn_classify()
train_data=loadDataFile('hw1_train.data');
disp(train_data)
train_label=loadLabelFile('hw1_train.data');
disp(train_label)
new_data=loadDataFile('hw1_test.data');
disp(new_data)
new_label=loadLabelFile('hw1_test.data');
disp(new_label)
[new_accu, train_accu]=knn_classify1(train_data,train_label,new_data,new_label,1);
end 

function [new_accu, train_accu] = knn_classify1(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567: Machine Learning, Spring 2016, Homework 1
new_accu='A';
train_accu='B';
end

function data=loadDataFile(file)
fileID = fopen(file);
C = textscan(fileID,'%s %s %s %s %s %s %s','Delimiter',',');
fclose(fileID);
A=[C{1},C{2},C{3},C{4},C{5},C{6},C{7}];
D=zeros(size(A,1),21);
for i=1:size(A,1),
for j=1:size(A,2),
if j==1,
if strcmp(A{i,j},'vhigh')
D(i,1)=0;
D(i,2)=0;
D(i,3)=0;
D(i,4)=1;
end
if strcmp(A{i,j},'high')
D(i,1)=0;
D(i,2)=0;
D(i,3)=1;
D(i,4)=0;
end
if strcmp(A{i,j},'med')
D(i,1)=0;
D(i,2)=1;
D(i,3)=0;
D(i,4)=0;
end
if strcmp(A{i,j},'low')
D(i,1)=1;
D(i,2)=0;
D(i,3)=0;
D(i,4)=0;
end 
elseif j==2,
if strcmp(A{i,j},'vhigh')
D(i,5)=0;
D(i,6)=0;
D(i,7)=0;
D(i,8)=1;
end
if strcmp(A{i,j},'high')
D(i,5)=0;
D(i,6)=0;
D(i,7)=1;
D(i,8)=0;
end
if strcmp(A{i,j},'med')
D(i,5)=0;
D(i,6)=1;
D(i,7)=0;
D(i,8)=0;
end
if strcmp(A{i,j},'low')
D(i,5)=1;
D(i,6)=0;
D(i,7)=0;
D(i,8)=0;
end
elseif j==3,
if strcmp(A{i,j},'2')
D(i,9)=0;
D(i,10)=0;
D(i,11)=0;
D(i,12)=1;
end
if strcmp(A{i,j},'3')
D(i,9)=0;
D(i,10)=0;
D(i,11)=1;
D(i,12)=0;
end
if strcmp(A{i,j},'4')
D(i,9)=0;
D(i,10)=1;
D(i,11)=0;
D(i,12)=0;
end
if strcmp(A{i,j},'5more')
D(i,9)=1;
D(i,10)=0;
D(i,11)=0;
D(i,12)=0;
end
elseif j==4,
if strcmp(A{i,j},'2')
D(i,13)=0;
D(i,14)=0;
D(i,15)=1;
end
if strcmp(A{i,j},'4')
D(i,13)=0;
D(i,14)=1;
D(i,15)=0;
end
if strcmp(A{i,j},'more')
D(i,13)=1;
D(i,14)=0;
D(i,15)=0;
end
elseif j==5,
if strcmp(A{i,j},'small')
D(i,16)=0;
D(i,17)=0;
D(i,18)=1;
end
if strcmp(A{i,j},'med')
D(i,16)=0;
D(i,17)=1;
D(i,18)=0;
end
if strcmp(A{i,j},'big')
D(i,16)=1;
D(i,17)=0;
D(i,18)=0;
end
elseif j==6,
if strcmp(A{i,j},'low')
D(i,19)=0;
D(i,20)=0;
D(i,21)=1;
end
if strcmp(A{i,j},'med')
D(i,19)=0;
D(i,20)=1;
D(i,21)=0;
end
if strcmp(A{i,j},'high')
D(i,19)=1;
D(i,20)=0;
D(i,21)=0;
end
end
end 
end
data=D;
end

function label=loadLabelFile(file)
fileID = fopen(file);
C = textscan(fileID,'%s %s %s %s %s %s %s','Delimiter',',');
fclose(fileID);
A=[C{1},C{2},C{3},C{4},C{5},C{6},C{7}];
B=zeros(size(A,1),1);
for i=1:size(A,1),
for j=1:size(A,2),
if j==7,
if strcmp(A{i,j},'unacc')
B(i,1)=4;
end
if strcmp(A{i,j},'acc')
B(i,1)=3;
end
if strcmp(A{i,j},'good')
B(i,1)=2;
end
if strcmp(A{i,j},'vgood')
B(i,1)=1;
end
end
end 
end
label=B;
end