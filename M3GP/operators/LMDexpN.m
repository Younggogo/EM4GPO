function y=LMDexpN(x)
% Negative value exponential 
y=exp(-x);

%if infinity happens just go to a high number 
%some negative number can change to a high positive number 
%generating inf numbers
y(isinf(y))=1000000000;