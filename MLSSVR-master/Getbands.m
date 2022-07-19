function Bandout = Getbands(X_train,Y_train,task)
%% 对每一个任务选择最优波段
Bands = [];
for i = 1:task
    F1=carspls(X_train,Y_train(:,i),10,5,'center',2000); 
    Band = F1.vsel;
    Bands = [Bands, Band];
end
Bandout = unique(Bands);
