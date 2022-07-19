function RSSmooth = CorData(RS)
    %% standard normal variate
    [m, n] = size(RS);
    RSMV = nanmean(RS); % 平均值
    RSSV = nanstd(RS,0); % 标准差
    RSSNV = (RS - repmat(RSMV,m,1))./repmat(RSSV,m,1);

    %% Savitzky-Golay derivative
    RSSmooth = [];
    nl=3;nr=3; %需要用的平滑点
    mm=2; % 平滑用的多项式选择
    ld=0;% 导数选择，小于m 
    c = savgol(nl,nr,mm,ld,n); % n为变量
    for j = 1:m
        RSSmoothOne = convlv(RSSNV(j,:),c);
        RSSmooth = [RSSmooth;RSSmoothOne];
    end
end