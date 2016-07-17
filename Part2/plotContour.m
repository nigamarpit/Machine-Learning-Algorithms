function plotContour(X,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure;
scatter(X(:,1),X(:,2),10,'yo')
gm = fitgmdist(X,k);
hold on
ezcontour(@(x,y)pdf(gm,[x y]),[-8 8],[-8 8]);
title('Scatter Plot and Fitted GMM Contour')
hold off
end

