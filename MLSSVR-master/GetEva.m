function [MSE,RMSE,R2,MAE,MAPE,RPD,RP] = GetEva(Y_test,predict_label,task)

MSE = zeros(1,task);
RMSE= zeros(1,task);
R2= zeros(1,task);
MAE= zeros(1,task);
MAPE= zeros(1,task);
RPD= zeros(1,task);
for i =1:task
    [MSE(i),RMSE(i),R2(i),MAE(i),MAPE(i),RPD(i)] = scoreRegression(Y_test(:,i),predict_label(:,i));
    RPm = corrcoef(predict_label(:,i),Y_test(:,i));
    RP(i) = RPm(1,2);
end

end