function [eigenvecs] = get_sorted_eigenvecs(X)
% input:
%   X - N*D data matrix, each row as a data sample
%       You must assume that the data samples are not zero-mean, thus you need to perform 
%       data transformation on X to make sure that the samples have zero-mean (PCA algorithm assumption),
%       before performing eigenvalue-eigenvector decomposition.
%       You may use MATLAB built-in function 'eig' to perform eigenvalue-eigenvector decomposition.
% output:
%   eigenvecs: D*D matrix, normalized eigenvectors (with length=1) sorted based on its eigenvalue magnitude, 
%              with d-th column corresponds to eigenvector with the d-th biggest eigenvalue
%              (e.g. 1st column corresponds to eigenvector with the biggest eigenvalue,
%               2nd column corresponds to eigenvector with 2nd biggest eigenvalue, etc.)
%
% CSCI 567 2016 Spring, Homework 5
% (put your code here...)
n = size(X,1);
s = (X'*X)./n;
[eigenvecs,deigenval] = eig(s);
eval = diag(deigenval)';
[D,index] = sort(eval,'descend');
eigenvecs = eigenvecs(:,index);
end