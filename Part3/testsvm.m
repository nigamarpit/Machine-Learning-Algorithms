function accu = testsvm( X, Y, w, b)
values = w'*X' + b;
y = zeros(length(values),1);
y(values>=0) = 1;
y(values<0) = -1;
accu = sum(y==Y)/length(Y);