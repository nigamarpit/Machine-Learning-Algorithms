function [w, b] = trainsvm(X,Y,C)
[n, d] = size(X);

H = diag([ones(d,1);zeros(n+1,1)]);
A = -[repmat(Y, 1, d+1) .* [X, ones(n,1)],eye(n)]; 
lb = -[inf(d+1,1); zeros(n,1)];
B = -ones(n,1);
f = [zeros(d+1,1); C*ones(n,1)];

[x,fval,exitflag,output,lamda] = quadprog(H,f,double(A),double(B),[],[],lb);
b = x(d+1);
w = x(1:d);
end

