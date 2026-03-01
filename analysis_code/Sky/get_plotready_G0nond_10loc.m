% Bingchen Liu May 20, 2024
% This code calculated all the variables/data needed for the
% "plot_G0_scaling_3loc.m" code
% This code calculate the scale for G0 and save the scales for nondF plot
% This code also include data 
% "K": include directional spread and peak wave number for incoming wave
% spectra
% "A": spectra info from model data and Weibull fit
% "SS": basic model run info from S.mat
% This analysis code only process 3 surf zone locations 


% note '_2025' indicates this is post AGU2024 version and save for paper
% plot in different file while keep the AGU2024 figure data

clear

addpath(genpath('/data1/nkumar/RIPX/M_Files'))
addpath(genpath('/data1/bliu'))
addpath(genpath('/home/ffeddersen/matlab'))


load('/data1/bliu/data/SS_A_ds_qced_10loc')


loc_num = length(A.wfit2.intw(1,:));


%% final scaling 
% ========================== take the good one for final plot

g = 9.81;

kh.slp2 = SS.h2.*SS.kl2pm;
kh.slp3 = SS.h3.*SS.kl3pm;
kh.slp4 = SS.h4.*SS.kl4pm;


Sk.Sk2_hb_beta = (SS.Dw2./(SS.hb2.^2.*((g.*(SS.h2)).^0.5)))./0.02;
Sk.Sk3_hb_beta = (SS.Dw3./(SS.hb3.^2.*((g.*(SS.h3)).^0.5)))./0.03;
Sk.Sk4_hb_beta = (SS.Dw4./(SS.hb4.^2.*((g.*(SS.h4)).^0.5)))./0.04;

G0_nond.slp2 = sqrt(A.wfit2.intw)./Sk.Sk2_hb_beta;
G0_nond.slp3 = sqrt(A.wfit3.intw)./Sk.Sk3_hb_beta;
G0_nond.slp4 = sqrt(A.wfit4.intw)./Sk.Sk4_hb_beta;

G0_data.slp2 = sqrt(A.wfit2.intw);
G0_data.slp3 = sqrt(A.wfit3.intw);
G0_data.slp4 = sqrt(A.wfit4.intw);% G0_nond.slp2 = sqrt(A.wfit2.intw)./Sk.Sk2_hb_Ir_div_solit;




G0_nond_all = [G0_nond.slp2(:);G0_nond.slp3(:);G0_nond.slp4(:);];
ds_all = [repmat(ds.sigtb2',loc_num,1);repmat(ds.sigtb3',loc_num,1);repmat(ds.sigtb4',loc_num,1)];


ftt = strcat('A*x+B');
ft = fittype( sprintf('%s',ftt));
opts = fitoptions( ft );
opts.Display = 'Off';
opts.StartPoint = [0.5 2]; % beginning parameters - amp, mu, std.

[f,gof]=fit(ds_all(~isnan(G0_nond_all)),G0_nond_all(~isnan(G0_nond_all)),ft, opts);

corr= corrcoef(ds_all(~isnan(G0_nond_all)),G0_nond_all(~isnan(G0_nond_all)));
rsquare_G0 = corr.^2;
ds_model = 0:0.1:15;
G0_model = ds_model.* f.A+f.B;
%% save 

README = "Data generated from 'get_plotready_G0nond_10loc.m'";
README = [README "Plot ready data, including AFTER qc 'ed'SS','A','ds','Sk'(scaling)"];
README = splitlines(README)';



save('/data1/bliu/data/plotready_G0_nond_10loc_2025','README','G0_nond','G0_nond_all','G0_model','ds','ds_all','ds_model','f','gof','G0_data','rsquare_G0')
save('/data1/bliu/data/G0_nond_10loc_allsk_2025','README','SS','ds','A','Sk','kh')