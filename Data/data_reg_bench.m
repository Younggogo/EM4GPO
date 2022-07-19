function [trainx, trainy, testx, testy] = data_reg_bench(problem,trainfilename_x,trainfilename_y,testfilename_x,testfilename_y)
%%DATA_REG_BENCH   Creates the training and testing data from symbolic
%                 regression problems used in community benchmarks. Based
%                 on "McDermott, Manzoni, Jaskowski, White, Castelli,
%                 Krawiec, Luke, Vanneschi, Harper, De Jong, O'Reilly;
%                 Genetic Programming Needs Better Benchmarks; GECCO '12
%                 Proceedings of the 14th international conference on
%                 Genetic and evolutionary computation; p.791-798; 2012                
%
%   Input arguments:
%      problem         - String corresponding to the wanted problem, match
%                        names inside above article
%      trainfilename_x - Filename for input training data
%      trainfilename_y - Filename for output training data
%      testfilename_x  - Filename for input testing data
%      testfilename_y  - Filename for output testing data
%      
%   Output arguments:
%      trainx          - matrix or vector containing input training data
%      trainy          - vector containing output training data
%      testx           - matrix or vector containing input testing data
%      testy           - vector containing output testingg data
%
% www.tree-lab.org
% Copyright (C) 2013 Emigdio Z.Flores
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
%%
validstr = 0;

% Koza-1 Regression problem
if strcmp(problem,'Koza-1')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = trainx + (trainx.^2) + (trainx.^3) + (trainx.^4);
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = testx + (testx.^2) + (testx.^3) + (testx.^4);
   validstr = 1;
end

% Koza-2 Regression problem
if strcmp(problem,'Koza-2')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = (trainx.^5) - 2.*(trainx.^3) + trainx;
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = (testx.^5) - 2.*(testx.^3) + testx;
   validstr = 1;
end

% Koza-3 Regression problem
if strcmp(problem,'Koza-3')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = (trainx.^6) - 2.*(trainx.^4) + (trainx.^2);
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = (testx.^6) - 2.*(testx.^4) + (testx.^2);
   validstr = 1;
end

% Nguyen-1 Regression problem
if strcmp(problem,'Nguyen-1')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = (trainx.^3) + (trainx.^2) + trainx;
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = (testx.^3) + (testx.^2) + testx;
   validstr = 1;
end

% Nguyen-3 Regression problem
if strcmp(problem,'Nguyen-3')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = (trainx.^5) + (trainx.^4) + (trainx.^3) + (trainx.^2) + trainx;
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = (testx.^5) + (testx.^4) + (testx.^3) + (testx.^2) + testx;
   validstr = 1;
end

% Nguyen-4 Regression problem
if strcmp(problem,'Nguyen-4')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = (trainx.^6) + (trainx.^5) + (trainx.^4) + (trainx.^3) + (trainx.^2) + trainx;
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = (testx.^6) + (testx.^5) + (testx.^4) + (testx.^3) + (testx.^2) + testx;
   validstr = 1;
end

% Nguyen-5 Regression problem
if strcmp(problem,'Nguyen-5')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = sin(trainx.^2).*cos(trainx) - 1;
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = sin(testx.^2).*cos(testx) - 1;
   validstr = 1;
end

% Nguyen-6 Regression problem
if strcmp(problem,'Nguyen-6')
   trainx = create_rnd_data(-1, 1, 1, 20);
   trainy = sin(trainx) + sin(trainx + trainx.^2);
   testx = create_rnd_data(-1, 1, 1, 20);
   testy = sin(testx) + sin(testx + testx.^2);
   validstr = 1;
end

% Nguyen-7 Regression problem
if strcmp(problem,'Nguyen-7')
   trainx = create_rnd_data(0, 2, 1, 20);
   trainy = log(trainx + 1) + log((trainx.^2) + 1);
   testx = create_rnd_data(0, 2, 1, 20);
   testy = log(testx + 1) + log((testx.^2) + 1);
   validstr = 1;
end

% Nguyen-8 Regression problem
if strcmp(problem,'Nguyen-8')
   trainx = create_rnd_data(0, 4, 1, 20);
   trainy = sqrt(trainx);
   testx = create_rnd_data(0, 4, 1, 20);
   testy = sqrt(testx);
   validstr = 1;
end

% Nguyen-9 Regression problem
if strcmp(problem,'Nguyen-9')
   trainx = create_rnd_data(-1, 1, 2, 100);
   trainy = sin(trainx(:,1)) + sin(trainx(:,2).^2);
   testx = create_rnd_data(-1, 1, 2, 100);
   testy = sin(testx(:,1)) + sin(testx(:,2).^2);
   validstr = 1;
end

% Nguyen-10 Regression problem
if strcmp(problem,'Nguyen-10')
   trainx = create_rnd_data(-1, 1, 2, 100);
   trainy = 2.*sin(trainx(:,1)).*cos(trainx(:,2));
   testx = create_rnd_data(-1, 1, 2, 100);
   testy = 2.*sin(testx(:,1)).*cos(testx(:,2));
   validstr = 1;
end

% Pagie-1 Regression problem
if strcmp(problem,'Pagie-1')
   trainx = create_cont_data(-5, 5, 2, 0.4);
   trainy = 1./(1 + trainx(:,1).^-4) + 1./(1 + trainx(:,2).^-4);
   testx = create_cont_data(-5, 5, 2, 0.4);
   testy = 1./(1 + testx(:,1).^-4) + 1./(1 + testx(:,2).^-4);
   validstr = 1;
end

% Korns-1 Regression problem
if strcmp(problem,'Korns-1')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 1.57 + (24.3.*trainx(:,4));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 1.57 + (24.3.*testx(:,4));
   validstr = 1;
end

% Korns-2 Regression problem
if strcmp(problem,'Korns-2')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 0.23 + 14.2.*((trainx(:,4) + trainx(:,2))./(3.*trainx(:,5)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 0.23 + 14.2.*((testx(:,4) + testx(:,2))./(3.*testx(:,5)));
   validstr = 1;
end

% Korns-3 Regression problem
if strcmp(problem,'Korns-3')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = -5.41 + 4.9.*(trainx(:,4) - trainx(:,1) + (trainx(:,2)./trainx(:,5)))./(3.*trainx(:,5));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = -5.41 + 4.9.*(testx(:,4) - testx(:,1) + (testx(:,2)./testx(:,5)))./(3.*testx(:,5));
   validstr = 1;
end

% Korns-4 Regression problem
if strcmp(problem,'Korns-4')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = -2.3 + 0.13.*sin(trainx(:,3));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = -2.3 + 0.13.*sin(testx(:,3));
   validstr = 1;
end

% Korns-5 Regression problem
if strcmp(problem,'Korns-5')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 3 + 2.13.*log(trainx(:,5));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 3 + 2.13.*log(testx(:,5));
   validstr = 1;
end

% Korns-6 Regression problem
if strcmp(problem,'Korns-6')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = real(1.3 + 0.13.*sqrt(trainx(:,3)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = real(1.3 + 0.13.*sqrt(testx(:,3)));
   validstr = 1;
end

% Korns-7 Regression problem
if strcmp(problem,'Korns-7')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 213.80940889.*(1 - exp(-0.54723748542.*trainx(:,1)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 213.80940889.*(1 - exp(-0.54723748542.*trainx(:,1)));
   validstr = 1;
end

% Korns-8 Regression problem
if strcmp(problem,'Korns-8')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = real(6.87 + 11.*sqrt(7.23.*trainx(:,1).*trainx(:,4).*trainx(:,5)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = real(6.87 + 11.*sqrt(7.23.*testx(:,1).*testx(:,4).*testx(:,5)));
   validstr = 1;
end

% Korns-9 Regression problem
if strcmp(problem,'Korns-9')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = real(sqrt(trainx(:,1)).*exp(trainx(:,3))./(log(trainx(:,2).*trainx(:,4).^2)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = real(sqrt(testx(:,1)).*exp(testx(:,3))./(log(testx(:,2).*testx(:,4).^2)));
   validstr = 1;
end

% Korns-10 Regression problem
if strcmp(problem,'Korns-10')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 0.81 + 24.3.*(2.*trainx(:,2) + 3.*trainx(:,3).^2)./(4.*trainx(:,4).^3 + 5.*trainx(:,5).^4);
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 0.81 + 24.3.*(2.*testx(:,2) + 3.*testx(:,3).^2)./(4.*testx(:,4).^3 + 5.*testx(:,5).^4);
   validstr = 1;
end

% Korns-11 Regression problem
if strcmp(problem,'Korns-11')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 6.87 + 11.*cos(7.23.*trainx(:,1).^3);
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 6.87 + 11.*cos(7.23.*testx(:,1).^3);
   validstr = 1;
end

% Korns-12 Regression problem
if strcmp(problem,'Korns-12')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 2 - 2.1.*cos(9.8*trainx(:,1)).*sin(1.3.*trainx(:,5));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 2 - 2.1.*cos(9.8*testx(:,1)).*sin(1.3.*testx(:,5));
   validstr = 1;
end

% Korns-13 Regression problem
if strcmp(problem,'Korns-13')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 32 - 3.*(tan(trainx(:,1)).*tan(trainx(:,3))./(tan(trainx(:,2)).*tan(trainx(:,4))));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 32 - 3.*(tan(testx(:,1)).*tan(testx(:,3))./(tan(testx(:,2)).*tan(testx(:,4))));
   validstr = 1;
end

% Korns-14 Regression problem
if strcmp(problem,'Korns-14')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = 22 - 4.2.*(cos(trainx(:,1)) - tan(trainx(:,2))).*(tanh(trainx(:,3))./sin(trainx(:,4)));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = 22 - 4.2.*(cos(testx(:,1)) - tan(testx(:,2))).*(tanh(testx(:,3))./sin(testx(:,4)));
   validstr = 1;
end

% Korns-15 Regression problem
if strcmp(problem,'Korns-15')
   trainx = create_rnd_data(-50, 50, 5, 10000);
   trainy = real(12 - 6.*(tan(trainx(:,1))./exp(trainx(:,2))).*(log(trainx(:,3)) - tan(trainx(:,4))));
   testx = create_rnd_data(-50, 50, 5, 10000);
   testy = real(12 - 6.*(tan(testx(:,1))./exp(testx(:,2))).*(log(testx(:,3)) - tan(testx(:,4))));
   validstr = 1;
end

% Keijzer-1 Regression problem
if strcmp(problem,'Keijzer-1')
   trainx = create_cont_data(-1, 1, 1, 0.1);
   trainy = 0.3.*trainx.*sin(2*pi.*trainx);
   testx = create_cont_data(-1, 1, 1, 0.001);
   testy = 0.3.*testx.*sin(2*pi.*testx);
   validstr = 1;
end

% Keijzer-2 Regression problem
if strcmp(problem,'Keijzer-2')
   trainx = create_cont_data(-2, 2, 1, 0.1);
   trainy = 0.3.*trainx.*sin(2*pi.*trainx);
   testx = create_cont_data(-2, 2, 1, 0.001);
   testy = 0.3.*testx.*sin(2*pi.*testx);
   validstr = 1;
end

% Keijzer-3 Regression problem
if strcmp(problem,'Keijzer-3')
   trainx = create_cont_data(-3, 3, 1, 0.1);
   trainy = 0.3.*trainx.*sin(2*pi.*trainx);
   testx = create_cont_data(-3, 3, 1, 0.001);
   testy = 0.3.*testx.*sin(2*pi.*testx);
   validstr = 1;
end

% Keijzer-4 Regression problem
if strcmp(problem,'Keijzer-4')
   trainx = create_cont_data(0, 10, 1, 0.05);
   trainy = (trainx.^3).*exp(-trainx).*cos(trainx).*sin(trainx).*((sin(trainx).*sin(trainx)).*cos(trainx)-1);
   testx = create_cont_data(0.05, 10.05, 1, 0.05);
   testy = (testx.^3).*exp(-testx).*cos(testx).*sin(testx).*((sin(testx).*sin(testx)).*cos(testx)-1);
   validstr = 1;
end

% Keijzer-5 Regression problem
if strcmp(problem,'Keijzer-5')
   trainx(:,1) = create_rnd_data(-1, 1, 1, 1000);
   trainx(:,2) = create_rnd_data(1, 2, 1, 1000);
   trainx(:,3) = create_rnd_data(-1, 1, 1, 1000);
   trainy = (30.*trainx(:,1).*trainx(:,3))./((trainx(:,1) - 10).*trainx(:,2).^2);
   testx(:,1) = create_rnd_data(-1, 1, 1, 10000);
   testx(:,2) = create_rnd_data(1, 2, 1, 10000);
   testx(:,3) = create_rnd_data(-1, 1, 1, 10000);   
   testy = (30.*testx(:,1).*testx(:,3))./((testx(:,1) - 10).*testx(:,2).^2);
   validstr = 1;
end

% Keijzer-6 Regression problem
if strcmp(problem,'Keijzer-6')
   trainx = create_cont_data(1, 50, 1, 1);
   l = length(trainx);
   for i=1:l
      trainy(i) = sum(1./trainx(1:i));
   end
   trainy = trainy';
   testx = create_cont_data(1, 120, 1, 1);
   l = length(testx);
   for i=1:l
      testy(i) = sum(1./testx(1:i));
   end
   testy = testy';
   validstr = 1;
end

% Keijzer-7 Regression problem
if strcmp(problem,'Keijzer-7')
   trainx = create_cont_data(1, 100, 1, 1);
   trainy = log(trainx);
   testx = create_cont_data(1, 100, 1, 0.1);
   testy = log(testx);
   validstr = 1;
end

% Keijzer-8 Regression problem
if strcmp(problem,'Keijzer-8')
   trainx = create_cont_data(0, 100, 1, 1);
   trainy = sqrt(trainx);
   testx = create_cont_data(0, 100, 1, 0.1);
   testy = sqrt(testx);
   validstr = 1;
end

% Keijzer-9 Regression problem
if strcmp(problem,'Keijzer-9')
   trainx = create_cont_data(0, 100, 1, 1);
   trainy = log(trainx + sqrt(trainx.^2 + 1));
   testx = create_cont_data(0, 100, 1, 0.1);
   testy = log(testx + sqrt(testx.^2 + 1));
   validstr = 1;
end

% Keijzer-10 Regression problem
if strcmp(problem,'Keijzer-10')
   trainx = create_rnd_data(0, 1, 2, 100);
   trainy = trainx(:,1).^trainx(:,2);
   testx = create_cont_data(0, 1, 2, 0.01);
   testy = testx(:,1).^testx(:,2);
   validstr = 1;
end

% Keijzer-11 Regression problem
if strcmp(problem,'Keijzer-11')
   trainx = create_rnd_data(-3, 3, 2, 20);
   trainy = (trainx(:,1).*trainx(:,2)) + sin((trainx(:,1) - 1).*(trainx(:,2) - 1));
   testx = create_cont_data(-3, 3, 2, 0.01);
   testy = (testx(:,1).*testx(:,2)) + sin((testx(:,1) - 1).*(testx(:,2) - 1));
   validstr = 1;
end

% Keijzer-12 Regression problem
if strcmp(problem,'Keijzer-12')
   trainx = create_rnd_data(-3, 3, 2, 20);
   trainy = trainx(:,1).^4 - trainx(:,1).^3 + ((trainx(:,2).^2)./2) - trainx(:,2);
   testx = create_cont_data(-3, 3, 2, 0.01);
   testy = testx(:,1).^4 - testx(:,1).^3 + ((testx(:,2).^2)./2) - testx(:,2);
   validstr = 1;
end

% Keijzer-13 Regression problem
if strcmp(problem,'Keijzer-13')
   trainx = create_rnd_data(-3, 3, 2, 20);
   trainy = 6.*sin(trainx(:,1)).*cos(trainx(:,2));
   testx = create_cont_data(-3, 3, 2, 0.01);
   testy =  6.*sin(testx(:,1)).*cos(testx(:,2));
   validstr = 1;
end

% Keijzer-14 Regression problem
if strcmp(problem,'Keijzer-14')
   trainx = create_rnd_data(-3, 3, 2, 20);
   trainy = 8./(2 + (trainx(:,1).^2) + (trainx(:,2).^2));
   testx = create_cont_data(-3, 3, 2, 0.01);
   testy =  8./(2 + (testx(:,1).^2) + (testx(:,2).^2));
   validstr = 1;
end

% Keijzer-15 Regression problem
if strcmp(problem,'Keijzer-15')
   trainx = create_rnd_data(-3, 3, 2, 20);
   trainy = ((trainx(:,1).^3)./5) + ((trainx(:,2).^3)./2) - trainx(:,2) - trainx(:,1);
   testx = create_cont_data(-3, 3, 2, 0.01);
   testy =  ((testx(:,1).^3)./5) + ((testx(:,2).^3)./2) - testx(:,2) - testx(:,1);
   validstr = 1;
end

% Vladislavleva-1 Regression problem
if strcmp(problem,'Vladislavleva-1')
   trainx = create_rnd_data(0.3, 4, 2, 100);
   trainy = (exp(-(trainx(:,1) - 1).^2))./(1.2 + (trainx(:,2) - 2.5).^2);
   testx = create_cont_data(-0.2, 4.2, 2, 0.1);
   testy =  (exp(-(testx(:,1) - 1).^2))./(1.2 + (testx(:,2) - 2.5).^2);
   validstr = 1;
end

% Vladislavleva-2 Regression problem
if strcmp(problem,'Vladislavleva-2')
   trainx = create_cont_data(0.05, 10, 1, 0.1);
   trainy = exp(-trainx).*(trainx.^3).*(cos(trainx).*sin(trainx)).*(cos(trainx).*(sin(trainx).^2).*trainx - 1);
   testx = create_cont_data(-0.5, 10.5, 1, 0.05);
   testy =  exp(-testx).*(testx.^3).*(cos(testx).*sin(testx)).*(cos(testx).*(sin(testx).^2).*testx - 1);
   validstr = 1;
end

% Vladislavleva-3 Regression problem
if strcmp(problem,'Vladislavleva-3')
   trainx(:,1) = create_cont_data(0.05, 10, 1, 0.1);
   trainx(:,2) = create_cont_data(0.05, 10.05, 1, 2);   
   trainy = exp(-trainx(:,1)).*(trainx(:,1).^3).*(cos(trainx(:,1)).*sin(trainx(:,1))).*(cos(trainx(:,1)).*(sin(trainx(:,1)).^2).*trainx(:,1) - 1).*(trainx(:,2) - 5);
   testx(:,1) = create_cont_data(-0.5, 10.5, 1, 0.05);
   testx(:,2) = create_cont_data(-0.5, 10.5, 1, 0.5);
   testy =  exp(-testx(:,1)).*(testx(:,1).^3).*(cos(testx(:,1)).*sin(testx(:,1))).*(cos(testx(:,1)).*(sin(testx(:,1)).^2).*testx(:,1) - 1).*(testx(:,2) - 5);
   validstr = 1;
end

% Vladislavleva-4 Regression problem
if strcmp(problem,'Vladislavleva-4')
   trainx = create_rnd_data(0.05, 6.05, 5, 1024);
   trainy = 10./(5 + ((trainx(:,1) - 3).^2) + ((trainx(:,2) - 3).^2) + ((trainx(:,3) - 3).^2) + ((trainx(:,4) - 3).^2) + ((trainx(:,5) - 3).^2));
   testx = create_rnd_data(-0.25, 6.35, 5, 5000);
   testy =  10./(5 + ((testx(:,1) - 3).^2) + ((testx(:,2) - 3).^2) + ((testx(:,3) - 3).^2) + ((testx(:,4) - 3).^2) + ((testx(:,5) - 3).^2));
   validstr = 1;
end

% Vladislavleva-5 Regression problem
if strcmp(problem,'Vladislavleva-5')
   trainx(:,1) = create_rnd_data(0.05, 2, 1, 300);
   trainx(:,2) = create_rnd_data(1, 2, 1, 300);
   trainx(:,3) = create_rnd_data(0.05, 2, 1, 300);
   trainy = 30.*(trainx(:,1) - 1).*(trainx(:,3) - 1)./((trainx(:,2).^2).*(trainx(:,1) - 10));
   testx(:,1) = create_cont_data(-0.05, 2.1, 1, 0.15);
   testx(:,2) = create_cont_data(0.65, 2.05, 1, 0.1);
   testx(:,3) = create_cont_data(-0.05, 2.1, 1, 0.15);
   testy =  30.*(testx(:,1) - 1).*(testx(:,3) - 1)./((testx(:,2).^2).*(testx(:,1) - 10));
   validstr = 1;
end

% Vladislavleva-6 Regression problem
if strcmp(problem,'Vladislavleva-6')
   trainx = create_rnd_data(0.1, 5.9, 2, 30);
   trainy = 6.*sin(trainx(:,1)).*cos(trainx(:,2));
   testx = create_cont_data(-0.05, 6.05, 2, 0.02);
   testy =  6.*sin(testx(:,1)).*cos(testx(:,2));
   validstr = 1;
end

% Vladislavleva-7 Regression problem
if strcmp(problem,'Vladislavleva-7')
   trainx = create_rnd_data(0.05, 6.05, 2, 300);
   trainy = (trainx(:,1) - 3).*(trainx(:,2) - 3) + (2.*sin((trainx(:,1) - 4).*(trainx(:,2) - 4)));
   testx = create_rnd_data(-0.25, 6.35, 2, 1000);
   testy =  (testx(:,1) - 3).*(testx(:,2) - 3) + (2.*sin((testx(:,1) - 4).*(testx(:,2) - 4)));
   validstr = 1;
end

% Vladislavleva-8 Regression problem
if strcmp(problem,'Vladislavleva-8')
   trainx = create_rnd_data(0.05, 6.05, 2, 50);
   trainy = (((trainx(:,1) - 3).^4) + ((trainx(:,2) - 3).^3) - (trainx(:,2) - 3))./(((trainx(:,2) - 2).^4) + 10);
   testx = create_cont_data(-0.25, 6.35, 2, 0.2);
   testy =  (((testx(:,1) - 3).^4) + ((testx(:,2) - 3).^3) - (testx(:,2) - 3))./(((testx(:,2) - 2).^4) + 10);
   validstr = 1;
end

if validstr
   save(trainfilename_x,'trainx','-ascii');
   save(trainfilename_y,'trainy','-ascii');
   save(testfilename_x,'testx','-ascii');
   save(testfilename_y,'testy','-ascii');
else
   disp('Error: No valid problem found...Nothing to do!');
end


function data = create_rnd_data(limit_min, limit_max, nvars, ndata)
%%CREATE_RND_DATA  Creates randomly data and saves to file

for i=1:nvars
   data(:,i) = ((limit_max - limit_min).*rand(ndata,1)) + limit_min;
end

function data = create_cont_data(limit_min, limit_max, nvars, interval)
%%CREATE_CONT_DATA  Creates continuos data and saves to file

for i=1:nvars
   data(:,i) = limit_min:interval:limit_max;
end