function [R2,RMSET] = R2Eva(testY,predictY,task)

for i = 1:task
    diff = testY(:,i)-predictY(:,i);
    diff2 = diff.^2;
    MSE = sum(diff2)/size(predictY,1);
    RMSE = sqrt(MSE);
    meanTestY = mean(testY(:,i));
    diffTestY = testY(:,i)-meanTestY;
    diffTestY2 = diffTestY.^2;
%     R2(1,i) = 1-sum(diff2(:))/sum(diffTestY2(:));
    R2(1,i) = MSE;
    RMSET(1,i) = RMSE;
end 

end