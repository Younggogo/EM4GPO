function RSSmooth = CorData(RS)
    %% standard normal variate
    [m, n] = size(RS);
    RSMV = nanmean(RS); % ƽ��ֵ
    RSSV = nanstd(RS,0); % ��׼��
    RSSNV = (RS - repmat(RSMV,m,1))./repmat(RSSV,m,1);

    %% Savitzky-Golay derivative
    RSSmooth = [];
    nl=3;nr=3; %��Ҫ�õ�ƽ����
    mm=2; % ƽ���õĶ���ʽѡ��
    ld=0;% ����ѡ��С��m 
    c = savgol(nl,nr,mm,ld,n); % nΪ����
    for j = 1:m
        RSSmoothOne = convlv(RSSNV(j,:),c);
        RSSmooth = [RSSmooth;RSSmoothOne];
    end
end