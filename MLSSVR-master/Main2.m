clear;

%% 导入数据
% load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_RD2009_X.mat');
% load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_RD2009_Y.mat');
% RAWX = SWNIR_RD2009_X;
% RAWY = SWNIR_RD2009_Y;
load ('D:\研究成果\paper 10-多任务学习\Data\Corn\M5S.mat');
RAWX = M5S;
RAWY = Label;
realtask = 2; % the number of real real task
opetask = 4;% the number of operate task
mode = 1; % 1: random; 2: normal
runmodel = 1; % 1: without data preprocess, 2: with data preprocess
switch runmodel
    case 1
        %% creat dataset
        for i = 1:10 
            index = randperm(size(RAWX,1));
            ratio = 0.8;
            num_train = round(ratio*length(index));
            index_train = index(1:num_train);
            index_test = index((1+num_train):end);
            X_train = RAWX(index_train,:);
            X_test = RAWX(index_test,:);
            Y_train = RAWY(index_train,:);
            Y_test = RAWY(index_test,:);
            % Train and test dataset (randomly rank data)
            F1=carspls(X_train,Y_train(:,1),10,5,'center',2000); 
            Bands = F1.vsel;
%             F2=carspls(X_train,Y_train(:,2),10,5,'center',2000); 
%             Band2 = F2.vsel;
%             Band = [Band1,Band2];
%             Bands = unique(Band);
            X_train = X_train(:,Bands);
            X_test = X_test(:,Bands);
            [X,Y] = CreEveData(X_train,Y_train,realtask,opetask,mode); 
            [Xt,Yt] = CreEveData(X_test,Y_test,realtask,opetask,mode);

            %% model train
            d = size(X{1}, 2);  % dimensionality.
            lambda = [0 0.1];
            opts.init = 0;      % guess start point from data. 
            opts.tFlag = 1;     % terminate after relative objective value does not changes much.
            opts.tol = 10^-6;   % tolerance. more low more accurate
            opts.maxIter = 10000; % maximum iteration number of optimization.
            sparsity = zeros(length(lambda), 1);

            for i = 1:length(lambda)
                [W funcVal] = Least_L21(X, Y, lambda(i), opts);
                % set the solution as the next initial point. 
                % this gives better efficiency. 
                opts.init = 1;
                opts.W0 = W;
                sparsity(i) = nnz(sum(W,2 )==0)/d;
            end

            %% model test
        %     task_num = length(Xt);
            y_pred = cell(1, realtask);
            for t = 1 : realtask
                y_pred{1,t} = Xt{1,t} * W(:, t);
                RMSE{1,t} = sqrt(sum((y_pred{1,t}-Yt{1,t}).^2)/length(Yt{1,t}));
                RSQ{1,t} =rsq(Yt{1,t},y_pred{1,t});
            end
            res = sprintf('RMSE1 is %.4f, R1^2 is  %.4f, RMSE2 is %.4f, R2^2 is  %.4f',RMSE{1,1},sqrt(RSQ{1,1}),RMSE{1,2},sqrt(RSQ{1,2}));
            disp(res)
        %     RMSETotal(i,1) = RMSE{1,1}; 
        end

    case 2
        %% creat dataset
        for i = 1:10 
            index = randperm(size(SWNIR_GD2009_X,1));
            ratio = 0.8;
            num_train = round(ratio*length(index));
            index_train = index(1:num_train);
            index_test = index((1+num_train):end);

            X_train = SWNIR_GD2009_X(index_train,:);
            X_test = SWNIR_GD2009_X(index_test,:);
            Y_train = SWNIR_GD2009_Y(index_train,:);
            Y_test = SWNIR_GD2009_Y(index_test,:);
            % Train and test dataset (randomly rank data)
%             F=carspls(X_train,SWNIR_GD2009_Y(:,1),10,5,'center',2000); 
%             bandselected = F.vsel;
%             SWNIR_GD2009_X1 = SWNIR_GD2009_X(:,bandselected);
            
            [X_train,minI,maxI] = premnmx(X_train');
            [Y_train,minL,maxL] = premnmx(Y_train'); 
            [X,Y] = CreEveData(X_train',Y_train',realtask,opetask,mode); 
            X_test = tramnmx(X_test',minI,maxI);
            [Xt,Yt] = CreEveData(X_test',Y_test,realtask,opetask,mode);



            %% model train
            d = size(X{1}, 2);  % dimensionality.
            lambda = [0 0.1];
            opts.init = 0;      % guess start point from data. 
            opts.tFlag = 1;     % terminate after relative objective value does not changes much.
            opts.tol = 10^-6;   % tolerance. more low more accurate
            opts.maxIter = 10000; % maximum iteration number of optimization.
            sparsity = zeros(length(lambda), 1);

            for i = 1:length(lambda)
                [W funcVal] = Least_L21(X, Y, lambda(i), opts);
                % set the solution as the next initial point. 
                % this gives better efficiency. 
                opts.init = 1;
                opts.W0 = W;
                sparsity(i) = nnz(sum(W,2 )==0)/d;
            end

            %% model test
        %     task_num = length(Xt);
            y_pred = cell(1, realtask);
            for t = 1 : realtask
                y_pred{1,t} = Xt{1,t} * W(:, t);
                y_pred{1,t} = (tramnmx(y_pred{1,t}',minL(t),maxL(t)))';
                RMSE{1,t} = sqrt(sum((y_pred{1,t}-Yt{1,t}).^2)/length(Yt{1,t}));
                RSQ{1,t} =rsq(Yt{1,t},y_pred{1,t});
            end
            res = sprintf('RMSE1 is %.4f, R1^2 is  %.4f, RMSE2 is %.4f, R2^2 is  %.4f',RMSE{1,1},sqrt(RSQ{1,1}),RMSE{1,2},sqrt(RSQ{1,2}));
            disp(res)
        %     RMSETotal(i,1) = RMSE{1,1}; 
        end
end