clc;
clear all;
% load polymer.mat;
% [gamma, lambda, p, MSE] = GridMLSSVR(trnX, trnY, 10); 
load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Apple2label\SWNIR_RD2009_X.mat');
load ('D:\�о��ɹ�\paper 10-������ѧϰ\Data\Apple2label\SWNIR_RD2009_Y.mat');
[gamma, lambda, p, MSE] = GridMLSSVR(SWNIR_RD2009_X, SWNIR_RD2009_Y, 10); 