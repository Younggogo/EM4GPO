%% Non-Donimation Sort
% This function sort the current popultion based on non-domination. All the
% individuals in the first front are given a rank of 1, the second front
% individuals are assigned rank 2 and so on. After assigning the rank the
% crowding in each front is calculated.

function f = non_domination_sort_mod(x,problem)
[N,M1] = size(x);
switch problem
    case 1 %两个优化目标
        M = 2;
        V = M1-2;
    case 2 %三个优化目标
        M = 3;
        V = M1 - 3;
end
front = 1;
% There is nothing to this assignment, used only to manipulate easily in
% MATLAB.
F(front).f = []; %偏序集
individual = []; %个体集合
for i = 1 : N
    % Number of individuals that dominate this individual
    individual(i).n = 0;%每个个体被支配的个数
    % Individuals which this individual dominate
    individual(i).p = [];%个体所支配的集合
    for j = 1 : N
        dom_less = 0;%优化目标小于的个数
        dom_equal = 0;%优化目标相等的个数
        dom_more = 0;%优化目标大于的个数
        for k = 1 : M
            if (x(i,V + k) < x(j,V + k))  %i的第V+k个目标与j的V+k个目标相比
                dom_less = dom_less + 1;  
            elseif (x(i,V + k) == x(j,V + k))
                dom_equal = dom_equal + 1;
            else
                dom_more = dom_more + 1;
            end
        end
        if dom_less == 0 & dom_equal ~= M  
            individual(i).n = individual(i).n + 1;
        elseif dom_more == 0 & dom_equal ~= M
            individual(i).p = [individual(i).p j];
        end
    end   
    if individual(i).n == 0  %如果个体没有被支配个体
        x(i,M + V + 1) = 1;  %设定其Rank为1
        F(front).f = [F(front).f i]; %把个体加入到当前的Rank集合中
    end
end
% Find the subsequent fronts
while ~isempty(F(front).f) 
   Q = [];
   for i = 1 : length(F(front).f) 
       if ~isempty(individual(F(front).f(i)).p)
        	for j = 1 : length(individual(F(front).f(i)).p)
            	individual(individual(F(front).f(i)).p(j)).n = ...
                	individual(individual(F(front).f(i)).p(j)).n - 1;
        	   	if individual(individual(F(front).f(i)).p(j)).n == 0
               		x(individual(F(front).f(i)).p(j),M + V + 1) = ...
                        front + 1;
                    Q = [Q individual(F(front).f(i)).p(j)];
                end
            end
       end
   end
   front =  front + 1;
   F(front).f = Q;
end
[temp,index_of_fronts] = sort(x(:,M + V + 1));
for i = 1 : length(index_of_fronts)
    sorted_based_on_front(i,:) = x(index_of_fronts(i),:);
end




%%
current_index = 0;
% Find the crowding distance for each individual in each front
for front = 1 : (length(F) - 1)
    objective = [];
    distance = 0;
    y = [];
    previous_index = current_index + 1;
    for i = 1 : length(F(front).f)
        y(i,:) = sorted_based_on_front(current_index + i,:);
    end
    current_index = current_index + i;
    % Sort each individual based on the objective
    %sorted_based_on_objective = [];
    for i = 1 : M
        [sorted_based_on_objective, index_of_objectives] = ...
            sort(y(:,V + i));
        sorted_based_on_objective = [];
        for j = 1 : length(index_of_objectives)
            sorted_based_on_objective(j,:) = y(index_of_objectives(j),:);
        end
        f_max = ...
            sorted_based_on_objective(length(index_of_objectives), V + i);
        f_min = sorted_based_on_objective(1, V + i);
        y(index_of_objectives(length(index_of_objectives)),M + V + 1 + i)...
            = Inf;
        y(index_of_objectives(1),M + V + 1 + i) = Inf;
         for j = 2 : length(index_of_objectives) - 1
            next_obj  = sorted_based_on_objective(j + 1,V + i);
            previous_obj  = sorted_based_on_objective(j - 1,V + i);
            if (f_max - f_min == 0)
                y(index_of_objectives(j),M + V + 1 + i) = Inf;
            else
                y(index_of_objectives(j),M + V + 1 + i) = ...
                     (next_obj - previous_obj)/(f_max - f_min);
            end
         end
    end
    distance = [];
    distance(:,1) = zeros(length(F(front).f),1);
    for i = 1 : M
        distance(:,1) = distance(:,1) + y(:,M + V + 1 + i);
    end
    y(:,M + V + 2) = distance;
    y = y(:,1 : M + V + 2);
    z(previous_index:current_index,:) = y;
end
f = z();
disp(length(f));