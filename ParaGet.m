clc;
clear all;
% load polymer.mat;
% [gamma, lambda, p, MSE] = GridMLSSVR(trnX, trnY, 10); 
load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_RD2009_X.mat');
load ('D:\研究成果\paper 10-多任务学习\Data\Apple2label\SWNIR_RD2009_Y.mat');
[gamma, lambda, p, MSE] = GridMLSSVR(SWNIR_RD2009_X, SWNIR_RD2009_Y, 10); 