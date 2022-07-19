function [XT,XTe] = TrteDataSt(X,Xtest)
%% ѵ�����ݱ�׼
    X_mean = mean(X);
    X_diag = diag(1./std(X,0,1));
    XT = (X -repmat(X_mean, size(X,1), 1))*X_diag; % ����ȥ���Ļ�
    XT(isnan(XT)) = 1;
%% �������ݱ�׼
    XTe = (Xtest -repmat(X_mean, size(Xtest,1), 1))*X_diag;
    XTe(isnan(XTe)) = 1;
end