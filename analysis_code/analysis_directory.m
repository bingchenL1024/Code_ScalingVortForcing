% Bingchen Liu May 20, 2024
% overall analysis directory 
% it includes all analysis for 
% Sky
%   G0
%   ky0
% C_XT
%   C_T
%   C_X



addpath(genpath('/data1/bliu/'))
addpath('/home/ffeddersen/matlab')
addpath(genpath('/data1/nkumar/RIPX/M_Files'))
addpath(genpath('/data1/bliu'))
rmpath('/data1/bliu/Ata_work/matlab/ROMS/') %make sure Ata's code does not override Matlab default function
clear

%% ======================== evaluate best expo for WB fit
clear
get_rmse_diffWBexpo

plot_rmseVSexpo




%% Analysis code needed for calculation of nond G0 -- 10 locaitons 

 
%================> for plot nond Sky <==========================
clear 
tic
expo = 1.4; % Choose the exponent

get_Sky_weibul_fits_log_BL_testexp_10loc
clearvars -except expo

get_weibul_qced_10loc
clearvars -except expo

get_nond_spectra_10loc 
clearvars -except expo

get_nond_binmean_spectra_10loc
clearvars -except expo
toc
 

%  ===============>for getting nond G0 and ky0 and their analysis <=======
clear
tic

expo = 1.4;
get_Sky_weibul_fits_log_BL_10loc         
clear
1
get_SS_ds_10loc
clear
2
get_data_qc_G0nond
clear
3
get_plotready_G0nond_10loc
clear
4
clear
get_plotready_ky0nond_10loc
clear
5

%% ========================= CXT ===============================


1
get_cxt_ind_good
clear

2
get_CXT_qced

3
get_4panel_cxtatx

4
get_cxt_alongct_nointerp_max_dxwidth


5 %
get_cxt_fit_nointerp_max_dxwidth


6
get_CXT_scaling2fit

7
get_cxt_5loc


8
get_cxt_fitanalysis_max_dxwidth


9
get_cxt_dxwidth_analysis




