function [ind state] = MTLSSVMfItness(ind,params,data,state,gen,varsvals,ban)
X=data.example;
Y=data.result;
%LMD z method to run faster fitness evaluation 
if ban == 1
   load('test_terminals.mat'); 
else
   load('train_terminals.mat'); 
end


globalDim = length(ind.tree.kids);
samples = size(Y,1);

Z = zeros(samples,globalDim);
% bandindextotal = [];
for t = 1:globalDim
		Trn = tree2str(ind.tree.kids{t});
    try
        Z(:,t)=eval(Trn);		
    catch 
            % because of the "nesting 32" error of matlab
 			zmd=str2num(evaluate_tree(ind.tree.kids{t},X));
            if length(zmd) == samples
               Z(:,t) = zmd;
            else
               Index = str2num(Trn(isstrprop(Trn,'digit')));
               Z(:,t) = X(:,Index); 
            end
            % error('LMD: something is wrong with the fitness function')
    end
    if length(Z(:,t))<samples
%        Z(:,t)=ones(samples,1);
       Z(:,t)=Z(:,t).*ones(samples,1);
    end
%     bandindextotal = [bandindextotal,bandindextrn]; 
%     if isempty(zmd)
%         Z(:,t) = zeros(samples,1);
%     else
%         Z(:,t) = zmd.*ones(samples,1);
%     end
end 
task = 3; % ÈÎÎñÊý
if ban == 1 
   %% test
    X_mean = max(Z);
    X_diag = min(Z); 
    minm = repmat(X_diag, size(Y,1), 1); 
    maxm = repmat(X_mean, size(Y,1), 1); 
    Test_x_Z = (Z -minm)./(maxm - minm);   
    Test_x_Z(isnan(Test_x_Z)) = 1;
    Train_x = Test_x_Z(1:round(0.75*size(Test_x_Z,1)),:);
    Test_x = Test_x_Z((1+round(0.75*size(Test_x_Z,1))+1):end,:);
    Test_y = Y((1+round(0.75*size(Test_x_Z,1))+1):end,:);
    
    %% model
    modelwb = ind.RegCoef;
    P = ind.Train_Error;  
    Q = ind.Train_RSME;
    
    %% calculate test 
    ProxY = CalTest(Test_x, Test_y,Train_x,modelwb,task, Q);
    [MAE,RMSE] = R2Eva(Test_y,ProxY,task);    
   
    %% test accuracy
   	sumdif = RMSE;
	ind.fitness=fixdec(sumdif,params.precision);   
    	
	ind.Test_Error = MAE;
    ind.Test_RSME = RMSE;
	ind.Test_MSE= RMSE;
	ind.Test_MAE= MAE;

else
    %% processing data
    X_mean = max(Z);
    X_diag = min(Z);
    minm = repmat(X_diag, size(Z,1), 1); 
    maxm = repmat(X_mean, size(Z,1), 1); 
    Train_x_Z = (Z -minm)./(maxm - minm);
    Train_x_Z(isnan(Train_x_Z)) = 1;
    
    %% train data
    Train_x = Train_x_Z(1:round(0.75*size(Train_x_Z,1)),:);
    Train_y = Y(1:round(0.75*size(Train_x_Z,1)),:);
    
    %% private feature and fitness
    [PF1,WB,PF2,FT] = EXPF(Train_x,Train_y,task);
    sumdif = FT;
    
    ind.fitness=fixdec(sumdif,params.precision);
    %% save PF and model
    ind.Train_Error = PF1;  
    ind.Train_RSME= PF2;
	ind.Train_MSE= FT;
    ind.Train_MAE= FT;
    ind.RegCoef = [WB];

end
