function Bandout = Getbands(X_train,Y_train,task)
%% ��ÿһ������ѡ�����Ų���
Bands = [];
for i = 1:task
    F1=carspls(X_train,Y_train(:,i),10,5,'center',2000); 
    Band = F1.vsel;
    Bands = [Bands, Band];
end
Bandout = unique(Bands);
