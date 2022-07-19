function [PF1,WB,PF2,FT] = EXPF(Train_x,Train_y,task)

PF1 = zeros(1,task);
PF2 = zeros(1,task);
FT = zeros(1,task);
WB = cell(2,task);
for j = 1:task
   [gamma, lambda, p, FT(1,j)] = GridMLSSVR(Train_x, Train_y(:,j), 10);
   [alpha, b] = MLSSVRTrain(Train_x, Train_y(:,j), gamma, lambda, p);
   PF1(1,j) = gamma;
   PF2(1,j) = p;
   WB{1,j} = alpha;
   WB{2,j} = b;
end

end