
% Bingchen Liu June 22, 2024
% This code calculated all the variables/data needed for the
% "plot_ky0_scaling_3loc.m" code
% This code calculate the scale for ky0 and save the scales for nondky0 plot
% This code also include data 
% This analysis code only process 3 surf zone locations 

% "K": include directional spread and peak wave number for incoming wave
% spectra
% "A": spectra info from model data and Weibull fit
% "SS": basic model run info from S.mat


clear
load('/data1/bliu/data/plotready_G0_nond_10loc_2025')
load('/data1/bliu/data/G0_nond_10loc_allsk_2025')


%%%%%%%%%%%%%%%%%%%%%%%%%
loc_num =length(G0_nond.slp2(1,:));

power_Ir = 0.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% with 1/h
sk_ky0.Sk2_h=1./(SS.h2);
sk_ky0.Sk3_h=1./(SS.h3);
sk_ky0.Sk4_h=1./(SS.h4);

sk_ky0.Sk2_h_beta_X=(1./SS.h2).*SS.beta2;
sk_ky0.Sk3_h_beta_X=(1./SS.h3).*SS.beta3;
sk_ky0.Sk4_h_beta_X=(1./SS.h4).*SS.beta4;

sk_ky0.Sk2_h_beta_div=(1./SS.h2)./SS.beta2;
sk_ky0.Sk3_h_beta_div=(1./SS.h3)./SS.beta3;
sk_ky0.Sk4_h_beta_div=(1./SS.h4)./SS.beta4;

sk_ky0.Sk2_h_Ir_X=(1./SS.h2).*SS.Ir2;
sk_ky0.Sk3_h_Ir_X=(1./SS.h3).*SS.Ir3;
sk_ky0.Sk4_h_Ir_X=(1./SS.h4).*SS.Ir4;

sk_ky0.Sk2_h_Ir_div=(1./SS.h2)./SS.Irb2.^(power_Ir);
sk_ky0.Sk3_h_Ir_div=(1./SS.h3)./SS.Irb3.^(power_Ir);
sk_ky0.Sk4_h_Ir_div=(1./SS.h4)./SS.Irb4.^(power_Ir);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% with kw
sk_ky0.Sk2_kw=SS.kl2pm;
sk_ky0.Sk3_kw=SS.kl3pm;
sk_ky0.Sk4_kw=SS.kl4pm;

sk_ky0.Sk2_kw_beta_X=SS.kl2pm.*SS.beta2;
sk_ky0.Sk3_kw_beta_X=SS.kl3pm.*SS.beta3;
sk_ky0.Sk4_kw_beta_X=SS.kl4pm.*SS.beta4;

sk_ky0.Sk2_kw_beta_div=SS.kl2pm./SS.beta2;
sk_ky0.Sk3_kw_beta_div=SS.kl3pm./SS.beta3;
sk_ky0.Sk4_kw_beta_div=SS.kl4pm./SS.beta4;

sk_ky0.Sk2_kw_Ir_X=SS.kl2pm.*SS.Ir2;
sk_ky0.Sk3_kw_Ir_X=SS.kl3pm.*SS.Ir3;
sk_ky0.Sk4_kw_Ir_X=SS.kl4pm.*SS.Ir4;

sk_ky0.Sk2_kw_Ir_div=SS.kl2pm./SS.Ir2;
sk_ky0.Sk3_kw_Ir_div=SS.kl3pm./SS.Ir3;
sk_ky0.Sk4_kw_Ir_div=SS.kl4pm./SS.Ir4;




% pick the good scaling using Sk2_h_beta_div

ky0_nond.slp2 = A.wkym2./sk_ky0.Sk2_h_Ir_div;
ky0_nond.slp3 = A.wkym3./sk_ky0.Sk3_h_Ir_div;
ky0_nond.slp4 = A.wkym4./sk_ky0.Sk4_h_Ir_div;

ky0_data.slp2 = A.wkym2;
ky0_data.slp3 = A.wkym3;
ky0_data.slp4 = A.wkym4;


ky0_nond_all = [ky0_nond.slp2(:); ky0_nond.slp3(:); ky0_nond.slp4(:)];
ds_all = [repmat(ds.sigtb2',loc_num,1);repmat(ds.sigtb3',loc_num,1);repmat(ds.sigtb4',loc_num,1)];



ftt = strcat('A*x+B');
ft = fittype( sprintf('%s',ftt));
opts = fitoptions( ft );
opts.Display = 'Off';
opts.StartPoint = [0 0.00025]; % beginning parameters - amp, mu, std.

[f,gof]=fit(ds_all(~isnan(ky0_nond_all)),ky0_nond_all(~isnan(ky0_nond_all)),ft, opts);

corr= corrcoef(ds_all(~isnan(ky0_nond_all)),ky0_nond_all(~isnan(ky0_nond_all)));
rsquare_ky0 = corr.^2;

ds_model = 0:0.1:15;
ky0_model = ds_model.* f.A+f.B;
   
README = "Data generated from 'get_plotready_ky0nond_10loc.m'";
README = [README "Plot ready data, including AFTER qc 'ed'SS','A','ds','sk_ky0'(ky0 scaling)"];
README = splitlines(README)';



save('/data1/bliu/data/plotready_ky0_nond_10loc_2025','README','ky0_nond','ky0_nond_all','ds','ds_all','ds_model','ky0_model','f','gof',"ky0_data",'rsquare_ky0')


