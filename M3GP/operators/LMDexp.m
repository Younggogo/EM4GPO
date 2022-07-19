function y=LMDexp(x)
% exponential function 
y=exp(x);

%if infinity happens just go to a high number 
y(isinf(y))=1000000000;