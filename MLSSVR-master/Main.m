clc;
clear all;

%% ��������

load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Ԥ���������ݼ�\Apple2label\SWNIR_GD2010_X.mat');
load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Ԥ���������ݼ�\Apple2label\SWNIR_GD2010_Y.mat');
% RAWX = SWNIR_JG2009_X;
RAWX = CorData(SWNIR_GD2010_X);
RAWY = SWNIR_GD2010_Y;
Propval = {'Firmness','SSC'};
task = 1;
load('D:\Code\Improved-mae-data-augmentation\output\GD2010Augdata2')
%% sugar beet
% load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Sugar data\mwnir_WW_data.mat');
% RAWX = CorData(X_all(:,2:end));
% % RAWX = X_all(:,2:end);
% RAWY = Y_all(:,1:1);
% Propval = {'Moisture','SSC','sucrose content'};
% task = 1;

%% soil content
% load('D:\�о��ɹ�\paper 10-������ѧϰ\Compared method\���������ʺ���Ԥ��\soilconten.mat');
% Propval = {'N','P','K','pH','Mg','Ca'};
% task = 6;

%% corn
% RAWX =(RAWX - repmat(mean(RAWX),size(RAWX,1),1))./repmat(std(RAWX),size(RAWX,1),1);
% [RAWX,~] = TrteDataSt(RAWX,RAWX);
% load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Corn\MP5S.mat');
% Propval = {'Moisture','Oil','Protein ','Starch'};
% 
% RAWX = MP5S;
% RAWY = Label;


%% ������ʼ��

runtimes = 10;
% Bands = Getbands(RAWX,RAWY,task);
% RAWX = RAWX(:,Bands);
% [gamma, lambda, p, ~] = GridMLSSVR(RAWX, RAWY, 4); % 11 -2 -9 1 -10 -7
gamma =  2.^(1);
lambda = 2.^(-10); 
p = 2.^(-13);  
MSE = zeros(runtimes,task);
RMSE = zeros(runtimes,task);
R2 = zeros(runtimes,task);
MAE = zeros(runtimes,task);
MAPE = zeros(runtimes,task);
RPD = zeros(runtimes,task);
RP = zeros(runtimes,task);
%% create dataset
for i = 1:runtimes
    
    %% ��������
    ratio = 0.75;
    index = randperm(size(RAWX,1));
    num_train = round(ratio*length(index));
    index_train = index(1:num_train);
    index_test = index((1+num_train):end);
%     ratio = 0.8;
%     [~, dataindex] = sortrows(RAWY,1);
%     [index_train,index_test] = getindex(dataindex, ratio);  
    X_train = RAWX(index_train,:);
    X_test = RAWX(index_test,:);
    Y_train = RAWY(index_train,:);
    Y_test = RAWY(index_test,:);
    
    %% ������ǿ
%     [X_train, Y_train, X_test] = Dataaugmentation(X_train,Y_train,X_test);

    %% ����ѡ��
%     [g1, l1, p1, ~] = GridMLSSVR(X_train, Y_train, 10); % 11 -2 -9 
%     gamma =  2.^g1;
%     lambda = 2.^l1; 
%     p = 2.^p1; 
%     gamma =  3.^11;
%     lambda = 2.^(-2); 
%     p = 2.^(-9); 

    %% Train and test dataset (randomly rank data)��ά
%     Bands = Getbands(X_train,Y_train,task);
%     X_train = X_train(:,Bands);
%     X_test = X_test(:,Bands);

    %% ģ��ѵ����Ԥ��
    [alpha, b] = MLSSVRTrain(X_train, Y_train, gamma, lambda, p); % �ã�gamma p: sigma2
    [predict_label, total_squared_error, squared_correlation_coefficient] = ...
        MLSSVRPredict(X_test, Y_test, X_train, alpha, b, lambda, p); 
    
    %% ָ�����
    [MSEE,RMSEE,R2E,MAEE,MAPEE,RPDE,RPE] = GetEva(Y_test,predict_label, task);
    MSE(i,1:task)= MSEE;
    RMSE(i,1:task)= RMSEE;
    R2(i,1:task) = R2E;
    MAE(i,1:task)= MAEE;
    MAPE(i,1:task) = MAPEE;
    RPD(i,1:task) = RPDE;
    RP(i,1:task) = RPE;
end

  %% ƽ��ָ��
   MSEM = mean(MSE); RMSEM = mean(RMSE); R2M = mean(R2); 
   MAEM = mean(MAE); MAPEM = mean(MAPE); RPDM = mean(RPD);
   RPM = mean(RP);
   for s = 1:task
   res1 = sprintf('Task: %.10s,\n MSE1 is %.4f,\n RMSE is  %.4f,\n R2 is %.4f,\n MAE is  %.4f,\n MAPE is %.4f,\n RPD is  %.4f\n RP is  %.4f\n',...
      Propval{1,s}, MSEM(s),RMSEM(s),R2M(s),MAEM(s),MAPEM(s),RPDM(s),RPM(s));
   disp(res1)
   end    

