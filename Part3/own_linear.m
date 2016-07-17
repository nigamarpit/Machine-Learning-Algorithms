function accu = own_linear( train_X, train_Y, test_X, test_Y, c_max)

[w,b] = trainsvm(train_X, train_Y, c_max);
accu = testsvm(test_X, test_Y, w, b);
end