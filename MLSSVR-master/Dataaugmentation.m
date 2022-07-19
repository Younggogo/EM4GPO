function [DataRawAugX,DataRawAugY,X_test] = Dataaugmentation(RAWX,RAWY,X_test)

RAWXY = [RAWX,RAWY];
mode = 1; % �Ƿ��׼��
%% ѵ������ÿһά�ı�׼ƫ���+ - 0.1
EWStd = std(RAWX);
[m, n] = size(RAWX);
offsetaug = 9; % offset����
multipleaug = 0; % offset����
expandaug = 9; % offset����

if offsetaug == 0
   AugXOff = []; 
   AugYOff = [];
else
    AugXOff = [];
    for i = 1:offsetaug
        Offv = unifrnd(-0.1,0.1,m,n).*repmat(EWStd,m,1);
        AugXOffM = RAWX + Offv; % ����һ��
        AugXOff = [AugXOff; AugXOffM];
    end
    AugYOff = repmat(RAWY,offsetaug,1);
end
    AugXYO = [AugXOff,AugYOff];

%% ���ݳ˱�׼��
if multipleaug == 0
   AugXMul = [];
   AugYMul= [];
else
AugXMul = [];
for i = 1:multipleaug
    Mulv = unifrnd(-0.1,0.1,m,n);
    AugXMulM = RAWX.*((1 + Mulv).*repmat(EWStd,m,1)); % ����һ��
    AugXMul = [AugXMul; AugXMulM];
end
AugYMul= repmat(RAWY,multipleaug,1);
end
AugXYM = [AugXMul,AugYMul];

% %% ���ݵȱ���С��Ŵ�
% if multipleaug == 0
%    AugXMul = [];
%    AugYMul= [];
% else
% AugXMul = [];
% for i = 1:multipleaug
%     Mulv = unifrnd(-0.1,0.1,m,n);
%     AugXMulM = RAWX.*(1 + Mulv); % ����һ��
%     AugXMul = [AugXMul; AugXMulM];
% end
% AugYMul= repmat(RAWY,multipleaug,1);
% end
% AugXYM = [AugXMul,AugYMul];

%% �������Ʊ仯��С��Ŵ� ����Ч������
if expandaug == 0
    AugXExp = [];
    AugYExp = [];
else 
for t = 1:(n-1)
   RAWXD =  RAWX(:,t+1) - RAWX(:,t);
end
RAWXD(:,t+1) = 1;

AugXExp = [];
for i = 1:expandaug
    Expv = 1-unifrnd(-0.05,0.05,m,n);
    DC = RAWXD.*Expv;
    AugExpM = RAWX + DC;
    AugXExp = [AugXExp; AugExpM];
end
AugYExp= repmat(RAWY,expandaug,1);
end
AugXYExp = [AugXExp,AugYExp];

%% ��ʾ
% ax = 1:1:n;
% RY = mean(RAWX,1);
% RO = mean(AugXOff,1);
% RM = mean(AugXMul,1);
% RE = mean(AugXExp,1);
% plot(ax, RY,'+r',ax, RO, 'og', ax, RM,'^k', ax, RE,'<y');

DataRawAugX = [RAWX; AugXOff; AugXMul; AugXExp];
DataRawAugY = [RAWY; AugYOff; AugYMul; AugYExp];

%% ���ݱ�׼��
if mode == 1
    X_test = X_test; 
else
    meanv = mean(DataRawAugX,1);
    stdv = std(DataRawAugX,1);
    meanX = repmat(meanv,size(DataRawAugX,1),1);
    stdX = repmat(stdv,size(DataRawAugX,1),1);
    DataRawAugX = (DataRawAugX - meanX)./stdX;
    X_test = (X_test - repmat(meanv,size(X_test,1),1))./repmat(stdv,size(X_test,1),1);
end
end