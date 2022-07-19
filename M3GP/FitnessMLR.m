function ind = FitnessMLR(ind,params,data,state,varsvals,ban)
X=data.example;
Y=data.result;
%drawtree(ind.tree);

%LMD z method to run faster fitness evaluation 
if ban == 1
   load('test_terminals.mat'); 
else
    load('train_terminals.mat'); 
end


globalDim = length(ind.tree.kids);
samples = length(Y);

%unqClasses = unique(Y(1:samples));
%unqClasses = (1:params.ProblemClasses)';

Z = zeros(samples,globalDim);

for t = 1:globalDim
		Trn = tree2str(ind.tree.kids{t});
%LMD Z improvement for a faster gplab        
%     for i=params.numvars:-1:1
%         Trn=strrep(Trn,strcat('X',num2str(i)),strcat('X(:,',num2str(i),')'));
%     end

    try
        Z(:,t)=eval(Trn);		
    catch 
            % because of the "nesting 32" error of matlab
 			Z(:,t)=str2num(evaluate_tree(ind.tree.kids{t},X));
            % error('LMD: something is wrong with the fitness function')
    end
    if length(Z(:,t))<samples
       Z(:,t)=Z(:,t)*ones(samples,1);
    end
end    





if ban == 1 
   
    ZZZ= [ones(size(Z,1),1) Z];  
 
    ProxY  = zeros(size(ZZZ,1),1);
    
    for vars=1:size(ind.RegCoef,1)
        ProxY = ProxY + (ZZZ(:,vars)*ind.RegCoef(vars));
    end

	sumdif=sqrt(mean((ProxY - Y).^2));
	ind.fitness=fixdec(sumdif,params.precision);   
    
	
	ind.Test_Error = ProxY - Y;
    % root square mean error
	ind.Test_RSME= sqrt(mean((ProxY - Y).^2));
	%mean square error 
	ind.Test_MSE= mean((ProxY - Y).^2);
	%mean absolute error 
	ind.Test_MAE= mean(abs(ProxY - Y));

else  %Training 

    ZZZ= [ones(size(Z,1),1) Z];
     % mdl = GeneralizedLinearModel.fit (ZZZ,Y);
    RegCoef = regress(Y,ZZZ);
	ind.RegCoef = RegCoef;
    ProxY  = zeros(size(ZZZ,1),1);

    for vars=1:size(RegCoef,1)
        ProxY = ProxY + (ZZZ(:,vars)*RegCoef(vars));
    end
    
    sumdif=sqrt(mean((ProxY - Y).^2));
    
    
     %ind.fitness=sumdif; %lower fitness means better individual
     % now limit fitness precision, to eliminate rounding error problem:
     ind.fitness=fixdec(sumdif,params.precision);
    
    ind.Train_Error = ProxY - Y;
    % root square mean error
	ind.Train_RSME= sqrt(mean((ProxY - Y).^2));
	%mean square error 
	ind.Train_MSE= mean((ProxY - Y).^2);
	%mean absolute error 
	ind.Train_MAE= mean(abs(ProxY - Y));
    
end	
	
	

