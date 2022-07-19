function [XT,XTe] = TrteDataSt(X,Xtest)
%% 训练数据标准
    X_mean = mean(X);
    X_diag = diag(1./std(X,0,1));
    XT = (X -repmat(X_mean, size(X,1), 1))*X_diag; % 数据去中心化
    XT(isnan(XT)) = 1;
%% 测试数据标准
    XTe = (Xtest -repmat(X_mean, size(Xtest,1), 1))*X_diag;
    XTe(isnan(XTe)) = 1;
end