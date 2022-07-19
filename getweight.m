function W = getweight(W, gen, maxgen)
% 权重与迭代次数有关
% sum(W) = 1 
% 每过10代变化一次
W1 = W(2)*(1/W(1));% 将第二个权重变为1,第一个权重变化
Wmin = 0.005;
if gen == 0
    W(1) = W1;
    W(2) = 1;
else
    W(2) = 1;
    A = (Wmin - W1)/(maxgen - 1);
    B = W1 - A;
    W(1) = A*gen + B;
end
end