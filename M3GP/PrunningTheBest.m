function indBest = PrunningTheBest(indBest,data,params)
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
    for branch = 1 : Dimensions
        if (length(ind.tree.kids) ~= 1)
        clear Z covMM unqClasses totalClasses frqClasses distMatrix meanOfClassCluster; 
            globalDim = Dimensions-1;
            samples = length(X);


            Z = zeros(samples,globalDim);
            %Generates the new Z, taking out one dimension
            for t = 1:globalDim
                if t~= branch
                            Trn = tree2str(ind.tree.kids{t});
                    %LMD Z improvement for a faster gplab        
                    %     for i=params.numvars:-1:1
                    %         Trn=strrep(Trn,strcat('X',num2str(i)),strcat('X(:,',num2str(i),')'));
                    %     end

                        try
                            Z(:,t)=eval(Trn);		
                        catch 
                                % because of the "nesting 32" error of matlab
                                % drawtree(ind.tree);
                                % drawtree(ind.tree.kids{t});
                                Z(:,t)=str2num(evaluate_tree(ind.tree.kids{t},X));
                                 error('LMD: something is wrong with the fitness function')
                        end
                        if length(Z(:,t))<samples
                           Z(:,t)=Z(:,t)*ones(samples,1);
                        end
                end
            end    
 
            
    ZZZ= [ones(size(Z,1),1) Z];
     % mdl = GeneralizedLinearModel.fit (ZZZ,Y);
    RegCoef = regress(Y,ZZZ);
	ind.RegCoef = RegCoef;
    ProxY  = zeros(size(ZZZ,1),1);

    for vars=1:size(RegCoef,1)
        ProxY = ProxY + (ZZZ(:,vars)*RegCoef(vars));
    end
    
    sumdif=sqrt(mean((ProxY - Y).^2));
    
    IndPruning.fitness = fixdec(sumdif,params.precision);
            
            

            if IndPruning.fitness <= ind.fitness
                    %The tree that will receive the good dimensions 
                    nind.tree=maketreeMutlvlup(2,{'rand' 0},[0],0,'1',0,1,(Dimensions-1));
                    
                    %eliminates the extra dimension that is not helping the fitness
                        n1=1;
                        for n = 1: (Dimensions-1) % copy the old dimensions to the new tree with one dimension down
                            if (branch==n)
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

