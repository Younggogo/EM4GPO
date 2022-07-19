function indBest = PrunningTheBestRandom(indBest,data,params,gen)
%%The best individual of the population is going to be prune 
%to eliminate dimension that are not helping the classification

%% The pruning process
X=data.example;
Y=data.result; 
load('train_terminals.mat'); 

ind = indBest;

%If the tree is just one dimension pruning is not necessary 
if (length(ind.tree.kids) ~= 1)
        Dimensions = length(ind.tree.kids);
        IndPruning = ind;
        %Random list of branches to prune
        BranchToTest = randperm(Dimensions);
    for branch = 1 : Dimensions
        if (length(ind.tree.kids) ~= 1)
        clear Z covMM unqClasses totalClasses frqClasses distMatrix meanOfClassCluster; 
            globalDim = Dimensions-1;
            samples = size(X,1);
            Z = zeros(samples,globalDim);
            %Generates the new Z, taking out one dimension
            for t = 1:globalDim
                %If the branch is the one on the random list selected for
                %this turn it will be ignore
                if t~= BranchToTest(branch)
                            Trn = tree2str(ind.tree.kids{t});
                        try
                            Z(:,t)=eval(Trn);		
                        catch
                            zmd=str2num(evaluate_tree(ind.tree.kids{t},X));
                            if length(zmd) == samples
                               Z(:,t) = zmd;
                            else
                               Index = str2num(Trn(isstrprop(Trn,'digit')));
                               Z(:,t) = X(:,Index); 
                            end
%                             Z(:,t)=str2num(evaluate_tree(ind.tree.kids{t},X));
%                                  error('LMD: something is wrong with the fitness function')
                        end
                        if length(Z(:,t))<samples
                           Z(:,t)=Z(:,t)*ones(samples,1);
                        end
                end
            end    
            task =3;
            X_mean = max(Z);
            X_diag = min(Z);
            minm = repmat(X_diag, size(Z,1), 1); 
            maxm = repmat(X_mean, size(Z,1), 1); 
            Train_x_Z = (Z -minm)./(maxm - minm);
            Train_x_Z(isnan(Train_x_Z)) = 1;
            Train_x = Train_x_Z(1:round(0.75*size(Train_x_Z,1)),:);
            Train_y = Y(1:round(0.75*size(Train_x_Z,1)),:);
            Test_x = Train_x_Z((1+round(0.75*size(Train_x_Z,1))+1):end,:);
            Test_y = Y((1+round(0.75*size(Train_x_Z,1))+1):end,:);
            [PF1,WB,PF2,FT] = EXPF(Train_x,Train_y,task);
            sumdif = FT;
            IndPruning.fitness = fixdec(sumdif,params.precision);

            if IndPruning.fitness(1) <= ind.fitness(1) && IndPruning.fitness(2) <= ind.fitness(2) && IndPruning.fitness(3) <= ind.fitness(3)
                    %The tree that will receive the good dimensions 
                    nind.tree=maketreeMutlvlup(2,{'rand' 0},[0],0,'1',0,1,(Dimensions-1));
                    
                    %eliminates the extra dimension that is not helping the fitness
                        n1=1;
                        for n = 1: (Dimensions-1) % copy the old dimensions to the new tree with one dimension down
                            %If the branch is the one to be remove, do
                            %nothing and just by pass the branch.
                            if (BranchToTest(branch)==n)
                                n1=n1+1;
                            end
                            x1=nind.tree.kids{n}.nodeid; 
                            x2=ind.tree.kids{n1}.nodeid; 
                            [nind.tree,ind.tree]=swapnodes(nind.tree,ind.tree,x1,x2);
                            n1=n1+1;
                        end
                        %The new tree with one dimension less is assign to the individual
                        ind.tree = nind.tree;
                        ind.Z =	IndPruning.Z;
                        %ind.covM = IndPruning.covM ;
                        %ind.meanOfClassCluster = IndPruning.meanOfClassCluster;
                        ind.str=tree2str(ind.tree);
                        ind.nodes=ind.tree.nodes;
                        ind.fitness = IndPruning.fitness;
                        branch = 1 ;
                        Dimensions = length(ind.tree.kids);
            end
        end
            %clear Z covMM unqClasses totalClasses frqClasses distMatrix meanOfClassCluster; 

    end

end
ind.Pruned='True';
indBest=ind;

