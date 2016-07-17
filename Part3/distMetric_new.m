function [d] = distMetric_new(trainX)

pairWiseDist = pdist(trainX);
d = mean(pairWiseDist);

end