clc;
clear all;
warning ('off','all')

%% Experimental Parameters
directorio = pwd;% gets the current directory;
% Runs
 runs=1;
 gen=2000;
 pop=6;

%Selection
load('SNIRWhole');
selec='lexictour'; %tournament  SelectionNEAT lexictour
funcion='MTLSSVMfItness'; %Fitness for regression
% FunctionSet = 'Vladislavleva-A'; %ClassificationIM10
FunctionSet = 'Keijzer'; %
train_terminals = train_x;
test_terminals = test_x;
save train_x.txt 'train_x' -ascii;
save train_y.txt 'train_y' -ascii;			
save test_x.txt 'test_x' -ascii;
save test_y.txt 'test_y' -ascii;  
save('train_terminals','train_terminals');
save('test_terminals','test_terminals');
nom=['Keijzer-reg-'];

        %% Runs
        for i=1:runs
            
            close all
       
            Ejecutar='RunM3GP';
                              
            
            %% GPLAB-all parameters
			%% Mod the last parameter is to select the function set for the experiment 
            [v,b]=eval([Ejecutar,'(gen,pop,i,nom,train_x,train_y,test_x,test_y,funcion,selec,directorio,FunctionSet,i)']);
            save('Result3','v','b') 
        end % runs


fprintf('GP regression End...');
