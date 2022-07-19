function [v,b]=RunM3GP(gen,pop,inde,nom,train_x,train_y,test_x,test_y,funcion,selec,directorio,FunctionSet,mrun)
%function to run gplab main to automatically execute different configuration 

fprintf('GP classification running...');

p=resetparams;

%New settings for M3GP 
% Starting dimensions for first population.
p.dimensions = 1; 

p.precision = 5; %Solution precision E-5
p.keepevalssize = 0;

%Mutation and crossover for multidimensions
p=setoperators(p,'crossoverDlvl',2,2,'mutationDlvl',1,1);

 p.operatorprobstype='fixed';
 p.initialprobstype='fixed';
 %Operation probability mutation and crossover
 p.initialfixedprobs=[0.5 0.5];
%p.initialfixedprobs=[0.7 0.1 0.2];


%'mysqrt',1   'tan',1   'tanh',1  'Undivide',1  'negativo',1
%p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'sin',1,'cos',1,'mylog',1,'mypower',2);

%% Funciones set for benchmarks
if (strcmp (FunctionSet,'Koza'))%Koza 
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'sin',1,'cos',1,'LMDexp',1,'mylog',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'KozaOld'))%KozaOld
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'sin',1,'cos',1,'mylog',1,'mypower',2);    
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'Korns'))%Korns
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'sin',1,'cos',1,'LMDexp',1,'mylog',1,'mypower2',1,'mypower3',1,'mysqrt',1,'tan',1,'tanh',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'Keijzer'))%Keijzer 
p=setfunctions(p,'plus',2,'times',2,'Undivide',1,'negativo',1,'mysqrt',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'Vladislavleva-A'))%Vladislavleva-A
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'mypower2',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'Vladislavleva-B'))%Vladislavleva-B
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'mypower2',1,'LMDexp',1,'LMDexpN',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'Vladislavleva-C'))%Vladislavleva-C
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'mypower2',1,'LMDexp',1,'LMDexpN',1,'sin',1,'cos',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'ClassificationIM10'))
p=setfunctions(p,'plus',2,'minus',2,'times',2,'mydivide',2,'sin',1,'cos',1);
p=setterminals(p, 'rand');
elseif (strcmp (FunctionSet,'VJ'))
p=setfunctions(p, 'plus',2, 'minus',2, 'times',2, 'mydivide',2);
p=setterminals(p, 'rand');    
end 
%%

DirA=strcat(directorio,'\train_x.txt');
p.datafilex=DirA;
DirA=strcat(directorio,'\train_y.txt');
p.datafiley=DirA;


p.usetestdata=1;
DirA=strcat(directorio,'\test_x.txt');
p.testdatafilex=DirA;
DirA=strcat(directorio,'\test_y.txt');
p.testdatafiley=DirA;

p.calccomplexity=1;

p.inicmaxlevel=6;
p.fixedlevel=1;
p.dynamiclevel='0';
p.realmaxlevel=25;
p.depthnodes='1';
p.initpoptype='fullinit';    % rampedinit    fullinit

p.calcfitness=funcion;


p.elitism='keepbest';% replace keepbest  totalelitism   % halfelitism %LMDelitism
p.survival = 'fixedpopsize';
p.sampling=selec;
p.lowerisbetter=1; %Regression lower error is better

% Ejecuta GP 
[v,b]=gplab(gen,pop,p);



nombre=strcat('Results/',nom);
nombre=strcat(nombre,int2str(inde));

%Pull dimensions numbers from population for measurements
samples = length(v.pop);
for x = 1:samples 
    vector_Kids(x) = length(v.pop(x).tree.kids);
end
unqDimensions = unique(vector_Kids);
frqDimensions = histc(vector_Kids, unqDimensions);

% save(nombre, 'v', 'b','train_x','train_y','test_x','test_y','frqDimensions','unqDimensions'); 
