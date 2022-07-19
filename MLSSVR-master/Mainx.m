clc;
clear all;

%% 导入数据
% load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_JG2009_X.mat');
% load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_JG2009_Y.mat');
% RAWX = SWNIR_JG2009_X;
% % RAWX = CorData(SWNIR_GD2010_X);
% RAWY = SWNIR_JG2009_Y;
% Propval = {'Firmness','SSC'};
% task = 2;

%% sugar beet
load ('D:\研究成果\paper 10-多任务学习\Data\Sugar data\mwnir_ss_data.mat');
RAWX = CorData(X_all(:,2:end));
% RAWX = X_all(:,2:end);
RAWY = Y_all(:,1:3);
Propval = {'Moisture','SSC','sucrose content'};
task = 3;

%% corn
% RAWX =(RAWX - repmat(mean(RAWX),size(RAWX,1),1))./repmat(std(RAWX),size(RAWX,1),1);
% [RAWX,~] = TrteDataSt(RAWX,RAWX);
% load ('D:\研究成果\paper 10-多任务学习\Data\Corn\MP5S.mat');
% Propval = {'Moisture','Oil','Protein ','Starch'};
% 
% RAWX = MP5S;
% RAWY = Label;


%% 参数初始化

runtimes = 5;
Bands = Getbands(RAWX,RAWY,task);
RAWX = RAWX(:,Bands);
[gamma, lambda, p, ~] = GridMLSSVR(RAWX, RAWY, 10); % 11 -2 -9 1 -10 -7
% gamma =  2.^(5);
% lambda = 2.^(-2); 
% p = 2.^(-11);  
MSE = zeros(runtimes,task);
RMSE = zeros(runtimes,task);
R2 = zeros(runtimes,task);
MAE = zeros(runtimes,task);
MAPE = zeros(runtimes,task);
RPD = zeros(runtimes,task);

%% create dataset
for i = 1:runtimes
    
    %% 样本划分
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
    
    %% 样本增强
%     [X_train, Y_train, X_test] = Dataaugmentation(X_train,Y_train,X_test);

    %% 参数选择
%     [g1, l1, p1, ~] = GridMLSSVR(X_train, Y_train, 10); % 11 -2 -9 
%     gamma =  2.^g1;
%     lambda = 2.^l1; 
%     p = 2.^p1; 
%     gamma =  3.^11;
%     lambda = 2.^(-2); 
%     p = 2.^(-9); 

    %% Train and test dataset (randomly rank data)降维
%     Bands = Getbands(X_train,Y_train,task);
%     X_train = X_train(:,Bands);
%     X_test = X_test(:,Bands);

    %% 模型训练和预测
    [alpha, b] = MLSSVRTrain(X_train, Y_train, gamma, lambda, p);
    [predict_label, total_squared_error, squared_correlation_coefficient] = ...
        MLSSVRPredict(X_test, Y_test, X_train, alpha, b, lambda, p); 
    
    %% 指标计算
    [MSEE,RMSEE,R2E,MAEE,MAPEE,RPDE] = GetEva(Y_test,predict_label, task);
    MSE(i,1:task)= MSEE;
    RMSE(i,1:task)= RMSEE;
    R2(i,1:task) = R2E;
    MAE(i,1:task)= MAEE;
    MAPE(i,1:task) = MAPEE;
    RPD(i,1:task) = RPDE;
end

    %% 平均指标
   MSEM = mean(MSE); RMSEM = mean(RMSE); R2M = mean(R2); 
   MAEM = mean(MAE); MAPEM = mean(MAPE); RPDM = mean(RPD);
   for s = 1:task
   res1 = sprintf('Task: %.10s,\n MSE1 is %.4f,\n RMSE1 is  %.4f,\n R21 is %.4f,\n MAE1 is  %.4f,\n MAPE1 is %.4f,\n RPD1 is  %.4f\n',...
      Propval{1,s}, MSEM(s),RMSEM(s),R2M(s),MAEM(s),MAPEM(s),RPDM(s));
   disp(res1)
   end

