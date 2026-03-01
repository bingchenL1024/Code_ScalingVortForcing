% Binghcne Liu Jan 25, 2025
% This code qced the Weibull fit only. 



clearvars -except expo %rmse_diffexp badfit_num diffexpo % for loop part of master_analysisplot_WBexpochoice


addpath('/home/ffeddersen/matlab')
addpath(genpath('/data1/nkumar/RIPX/M_Files'))

load /data1/nkumar/RIPX/M_Files/Important_Files/qa_qc_RIPX_NK.mat % now S(1--120) struct is in memory


expo_name_temp = num2str(expo);
expo_name  = [expo_name_temp(1),'p',expo_name_temp(3:end)];

A = load(['/data1/bliu/data/Sky_WBfit_10loc_expo_',expo_name]);
load(['/data1/bliu/data/Sky_WBfit_10loc_expo_',expo_name]);

SS = load('Syscale');
K = load('locky');

qc_sk = 0.8;


%% get rsquare for G0 and ky0
G0_tot_data = [A.iS2s(:);A.iS3s(:);A.iS4s(:)].^(0.5);
G0_tot_fulldata = [A.iS2tot(:);A.iS3tot(:);A.iS4tot(:)].^(0.5);
G0_tot_WBfit = [A.wfit2.intw(:);A.wfit3.intw(:);A.wfit4.intw(:)].^(0.5);


ky0_tot_data = [A.kym2(:);A.kym3(:);A.kym4(:)];
ky0_tot_WBfit = [A.wkym2(:);A.wkym3(:);A.wkym4(:)];

r_G0full = corrcoef(G0_tot_data,G0_tot_fulldata);
stats.rsquare_G0full= r_G0full(1,2).^2;
stats.rmse_G0full = rmse(G0_tot_data,G0_tot_fulldata,'all');

r_G0 = corrcoef(G0_tot_data,G0_tot_WBfit);
stats.rsquare_G0 = r_G0(1,2).^2;
stats.rmse_G0 = rmse(G0_tot_data,G0_tot_WBfit,'all');

r_ky0 = corrcoef(ky0_tot_data,ky0_tot_WBfit);
stats.rsquare_ky0 = r_ky0(1,2).^2;
stats.rmse_ky0 = rmse(ky0_tot_data,ky0_tot_WBfit,'all');
%%
[p2,v2] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.02);
[p3,v3] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.03);
[p4,v4] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.04);

bla2 = find(A.wskil2(:)<=qc_sk);
bla3 = find(A.wskil3(:)<=qc_sk);
bla4 = find(A.wskil4(:)<=qc_sk);







head = 'get_weibul_qced.m';

save(['/data1/bliu/data/Sky_withWBfit_10loc_qced_',expo_name],'A','SS','Sky2_cutoff_runmean','Sky3_cutoff_runmean','Sky4_cutoff_runmean','magspec2','magspec3','magspec4','Skym2','Skym3','Skym4','ky2_cutoff','ky3_cutoff',"ky4_cutoff",'kym2','kym3','kym4', ...
    'Sky2_wb','Sky3_wb','Sky4_wb','mag_wb2','mag_wb3','mag_wb4','wkym2','wkym3','wkym4','ky2_wb','ky3_wb','ky4_wb','wfit2','wfit3','wfit4','Sky2_raw','Sky3_raw','Sky4_raw','ky_full','Sky2_full_runmean','Sky3_full_runmean','Sky4_full_runmean','head','stats')