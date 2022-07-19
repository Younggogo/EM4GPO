function [train_index,test_index] = getindex(dataindex, ratio)
train_index=[]; 
test_index=[];
Div = ratio/0.2 + 1;
for i = 1:length(dataindex)
    if rem(i,Div) == 0
        test_index = [test_index; dataindex(i)];
    else
        train_index = [train_index; dataindex(i)];
    end
end