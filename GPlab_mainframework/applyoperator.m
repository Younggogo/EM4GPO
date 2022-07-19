function [newpop,currentsize,pool,state]=applyoperator(pop,params,state,data,newpop,currentsize,opnum,pool)
%APPLYOPERATOR    Apply a genetic operator to create new GPLAB individuals.
%   NEWPOP=APPLYOPERATOR(POP,PARAMS,STATE,DATA,NEWPOP,NVALID,OPNUM,POOL)
%   returns a population where the new individuals created by applying the
%   genetic operator OPNUM have been added. This new population contains
%   valid individuals created with the operators, as well as empty individuals
%   with no tree representation. NEWPOP is the population being created,
%   where the new individuals are to be added; NVALID is the number of valid
%   individuals already part of this population; POOL is the indices of parents
%   already sampled for creating new individuals. If OPNUM=0, apply reproduction.
%
%   [NEWPOP,NVALID]=APPLYOPERATOR(...) also returns the updated number of
%   valid individuals in NEWPOP, after applying the genetic operator.
%
%   [NEWPOP,NVALID,POOL]=APPLYOPERATOR(...) also returns the decreased
%   pool after using some of the parents in the genetic operator.
%
%   [NEWPOP,NVALID,POOL,STATE]=APPLYOPERATOR(...) also returns the updated
%   state of the algorithm.
%
%   Input arguments:
%      POPULATION - the current population of the algorithm (array)
%      PARAMS - the running parameters of the algorithm (struct)
%      STATE - the current state of the algorithm (struct)
%      DATA - the dataset for use in the algorithm (struct)
%      NEWPOP - the new population being generated by the operators (array)
%      NVALID - the number of valid individuals already in NEWPOP (integer)
%      OPNUM - the number of the genetic operator to apply (integer)
%      POOL - the pool of parent indices to choose from (matrix)
%   Output arguments:
%      NEWPOP - the updated new population (array)
%      NVALID - the updated number of valid individuals in NEWPOP (integer)
%      POOL - the updated pool of parent indices (matrix)
%      STATE - the updated state of the algorithm (struct)
%
%   See also CROSSOVER, MUTATION, SAMPLING
%
%   Copyright (C) 2003-2007 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

popids=[pop.id];

% if needed, sample:
if isempty(pool)
   [pool,state.popexpected,state.popnormfitness]=sampling(pop,params,state,opnum);
end

% pick parents from pool:
[parents,pool]=pickparents(params,pool,opnum);

% and find their indices in popids:
parentindices=findfirstindex(popids,parents);

% apply operator to parents:
if opnum==0
   % reproduction
   state.reproductions=state.reproductions+1;
   validinds=pop(parentindices);
else
   % genetic operator
   newinds=feval(params.operatornames{opnum},pop,params,state,parentindices);
   state.operatorfreqs(opnum)=state.operatorfreqs(opnum)+1;
   % (even if this operator has not produced any valid children, its frequency is increased)
   
   % now the new individuals must be validated (except if they were cloned):
	[validinds,state]=validateinds(newinds,pop,params,state,data,parentindices,opnum);
end

% add the children into newpop:
n=currentsize;
m=length(validinds);
newpop(n+1:n+m)=validinds;
currentsize=n+m;
