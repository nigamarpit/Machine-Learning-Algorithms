function lrTemplate()
    load demoSynLR.mat
    
    %%
    % your codes here
    figureLR = figure(1);
    set(figureLR,'Position',[100, 100, 1000, 800]);
    X1= [ones(length(data1.x),1) data1.x];
    w1A=X1\data1.y;
    w1B=lrFit(data1.x, data1.y);
    plotLRline(figureLR, 1, w1A(1:2), w1B, data1.x, data1.y);
    X2= [ones(length(data2.x),1) data2.x];
    w2A=X2\data2.y;
    w2B=lrFit(data2.x, data2.y);
    plotLRline(figureLR, 2, w2A(1:2), w2B, data2.x, data2.y);
    X3= [ones(length(data3.x),1) data3.x];
    w3A=X3\data3.y;
    w3B=lrFit(data3.x, data3.y);
    plotLRline(figureLR, 3, w3A(1:2), w3B, data3.x, data3.y);
    X4= [ones(length(data4.x),1) data4.x];
    w4A=X4\data4.y;
    w4B=lrFit(data4.x, data4.y);
    plotLRline(figureLR, 4, w4A(1:2), w4B, data1.x, data1.y);
    
    
    figureLambda = figure(2);
    set(figureLambda,'Position',[100, 100, 1000, 800]);
    w11=lambdacalculation(data1.x,data1.y,0.1);
    w12=lambdacalculation(data1.x,data1.y,1);
    w13=lambdacalculation(data1.x,data1.y,10);
    w21=lambdacalculation(data2.x,data2.y,0.1);
    w22=lambdacalculation(data2.x,data2.y,1);
    w23=lambdacalculation(data2.x,data2.y,10);
    w31=lambdacalculation(data3.x,data3.y,0.1);
    w32=lambdacalculation(data3.x,data3.y,1);
    w33=lambdacalculation(data3.x,data3.y,10);
    w41=lambdacalculation(data4.x,data3.y,0.1);
    w42=lambdacalculation(data4.x,data3.y,1);
    w43=lambdacalculation(data4.x,data3.y,10);
    plotLambdaLines(figureLambda,1,w1A(1:2),w11,data1.x,data1.y);
    plotLambdaLines(figureLambda,1,w1A(1:2),w12,data1.x,data1.y);
    plotLambdaLines(figureLambda,1,w1A(1:2),w13,data1.x,data1.y);
    plotLambdaLines(figureLambda,2,w2A(1:2),w21,data2.x,data2.y);
    plotLambdaLines(figureLambda,2,w2A(1:2),w22,data2.x,data2.y);
    plotLambdaLines(figureLambda,2,w2A(1:2),w23,data2.x,data2.y);
    plotLambdaLines(figureLambda,3,w3A(1:2),w31,data3.x,data3.y);
    plotLambdaLines(figureLambda,3,w3A(1:2),w32,data3.x,data3.y);
    plotLambdaLines(figureLambda,3,w3A(1:2),w33,data3.x,data3.y);
    plotLambdaLines(figureLambda,4,w4A(1:2),w41,data4.x,data4.y);
    plotLambdaLines(figureLambda,4,w4A(1:2),w42,data4.x,data4.y);
    plotLambdaLines(figureLambda,4,w4A(1:2),w43,data4.x,data4.y);
        
    
    h1=leverage(data1.x);
    h2=leverage(data2.x);
    h3=leverage(data3.x);
    h4=leverage(data4.x);
    t1=studentized(data1.x,data1.y,w1B,h1);
    t2=studentized(data2.x,data2.y,w2B,h2);
    t3=studentized(data3.x,data3.y,w3B,h3);
    t4=studentized(data4.x,data4.y,w4B,h4);
    d1=cookDist(h1,t1,2);
    d2=cookDist(h2,t2,2);
    d3=cookDist(h3,t3,2);
    d4=cookDist(h4,t4,2);   
    figureSample = figure(3);
    set(figureSample,'Position',[100, 100, 1000, 800]);
    plotSamples(figureSample, 1, data1.x, data1.y, h1, t1, d1);
    plotSamples(figureSample, 2, data2.x, data2.y, h2, t2, d2);
    plotSamples(figureSample, 3, data3.x, data3.y, h3, t3, d3);
    plotSamples(figureSample, 4, data4.x, data4.y, h4, t4, d4);
    
    
    %%
    %     demo of TA's plot functions
    %     figureLR = figure(1);
    %     set(figureLR,'Position',[100, 100, 1000, 800]);
    %     plotLRline(figureLR, 1, w1A, w1B, data1.x, data1.y);
    %     plotLRline(figureLR, 2, w2A, w2B, data2.x, data2.y);
    %     plotLRline(figureLR, 3, w3A, w3B, data3.x, data3.y);
    %     plotLRline(figureLR, 4, w4A, w4B, data4.x, data4.y);
    %     
    %     figureSample = figure(2);
    %     set(figureSample,'Position',[100, 100, 1000, 800]);
    %     plotSamples(figureSample, 1, data1.x, data1.y, h1, t1, d1);
    %     plotSamples(figureSample, 2, data2.x, data2.y, h2, t2, d2);
    %     plotSamples(figureSample, 3, data3.x, data3.y, h3, t3, d3);
    %     plotSamples(figureSample, 4, data4.x, data4.y, h4, t4, d4);
end

function w3=lambdacalculation(dataX,dataY,lambda)
I=eye(size(dataX,2));
w3=pinv((dataX' * dataX)+(lambda*I))*(dataX'*dataY);
end

function r = heldoutResidual(w, dataValX, dataValY)
% evaluate/calculate the residual on heldout data
% your code here
yfit = polyval(w,dataValX);
r = dataValY - yfit;
end

function w = lrFit(dataX,dataY)
% fit the linear regression parameters    
% your code here
w = dataX\dataY;
end

function h = leverage(dataX)
% calculate leverage of every sample    
% your code here
h = dataX * pinv( dataX' * dataX) * dataX';
end

function t = studentized(dataX,dataY,w,h)
% calculate studentized residual for every sample
% your code here
t = (abs(dataY - (dataX*w))) / ((std(dataX(:,2))) *(sqrt( 1 - diag(h))));

end

function d = cookDist(h,t,k)
% calculate cook's distance for every sample
% your code here
d = (( h./(1-h) )) * ((t *t )/k);
end

function plotLRline(figureLR, subPID, w1, w2, dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    hleg = legend('majority','leverage','outlier','LR');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end

function plotSamples(figureLR, subPID, dataX, dataY, h, t, d)
% h, t, d: 
%   leverage, studentized_residual, cook's distance of samples
    [~, idxH] = max(h);
    [~, idxT] = max(t);
    [~, idxD] = max(d);
    
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot(dataX(idxH(1),2), dataY(idxH(1)), 'cd','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxT(1),2), dataY(idxT(1)), 'ms','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxD(1),2), dataY(idxD(1)), 'k>','MarkerSize',12,'LineWidth',3);
    hleg = legend('majority','leverage','outlier','max-H','max-T','max-Cook');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(', num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end

function plotLambdaLines(figureLambda, subPID, w1, w2, dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLambda)
    subplot(2,2,subPID), 
    hold on;
    plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on; 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    hold on;
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    hold on;
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    hold on;
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    hold on;
    hleg = legend('majority','leverage','outlier','Lambda');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end