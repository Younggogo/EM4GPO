function [pop,state]=fixedpopsize(pop,state,params)
%FIXEDPOPSIZE    Chooses fixed number of GPLAB individuals for next generation.
%   FIXEDPOPSIZE(POPULATION,STATE,PARAMS) returns the first STATE.POPSIZE
%   individuals from the ordered POPULATION (parents and offspring), for
%   the next generation. 
%   
%   Input arguments:
%      POPULATION - ordered list of (parents and offspring) individuals (array)
%      STATE - the current state of the algorithm (struct)
%      PARAMS - the parameters of the algorithm (struct)
%   Output arguments:
%      POPULATION - individuals surviving into the next generation (array)
%      STATE - the updated state of the algorithm (struct)
%
%   See also APPLYSURVIVAL, RESOURCES, PIVOTFIXE
%
%   Copyright (C) 2003-2007 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox


% simply choose the first state.popsize individuals from the already ordered list:

%LMD fix to really apply Lexicographic Parsimony Pressure
IndividualLPP = pop(1);
IndividualLPPno = 1;

for i = 2 : length(pop);
    if params.lowerisbetter %minimizing
        if IndividualLPP.fitness >= pop(i).fitness
             if IndividualLPP.nodes > pop(i).nodes
                 IndividualLPP =  pop(i);
                 IndividualLPPno = i;
             end
        end
    else  %maximizing
        if IndividualLPP.fitness <= pop(i).fitness
             if IndividualLPP.nodes > pop(i).nodes
                 IndividualLPP =  pop(i);
                 IndividualLPPno = i;
             end
        end          
    end
end
pop(IndividualLPPno) = pop(1);
pop(1)= IndividualLPP;

pop=pop(1:state.popsize);