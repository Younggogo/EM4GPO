function W = getweight(W, gen, maxgen)
% Ȩ������������й�
% sum(W) = 1 
% ÿ��10���仯һ��
W1 = W(2)*(1/W(1));% ���ڶ���Ȩ�ر�Ϊ1,��һ��Ȩ�ر仯
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