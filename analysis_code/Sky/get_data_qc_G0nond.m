% Skill of the fit. Skill done in Log space:
clear
addpath('/home/ffeddersen/matlab')
addpath(genpath('/data1/nkumar/RIPX/M_Files'))

A = load('/data1/bliu/data/Sky_WBfit_10loc.mat');

load('/data1/bliu/data/SS_ds_10loc');

[p2,v2] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.02);
[p3,v3] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.03);
[p4,v4] = get_sampled_ripx_spread_index(0.1, 2, 0.01, 0.5, 0.04);

% Get rid of skills that are less than 0
bla2 = find(A.lskil2(:,1)<=0.0);
bla3 = find(A.lskil3(:,1)<=0.0);
bla4 = find(A.lskil4(:,1)<=0.0);

bla22 = find(A.lskil2(:,2)<=0.0);
bla32 = find(A.lskil3(:,2)<=0.0);
bla42 = find(A.lskil4(:,2)<=0.0);

% Also, have a run in the 0.02 slope that has Weibul ky too large:
[I2,J2] = ind2sub([24 3],50);


%%
README = "Data generated from 'get_data_qc_G0nond_take_out_bad.m'";
README = [README "quality control of the 'SS'+A'+'ds' data"];
README = splitlines(README)';

save('/data1/bliu/data/SS_A_ds_qced_10loc','ds','A','SS','README')
