% Bingchen Liu Feb 18, 2025
% This code qc the raw CXT data: NaN CXT that is smaller than 95% level of
% null hypothesis 
clear
load ('/data1/bliu/data/raw/CXT_ALL_norm_and_var_21dx10dt_Bingchen.mat')


cxt_null=erfinv(0.95).*sqrt(2./(4801*12/(3*2))) % 6 DOF for alongshore loc --> 200 m decorrelation length scale alongshore
for runnum =1:120
    CXT_ALL{runnum}(abs(CXT_ALL{runnum})<=cxt_null) = NaN; 
end 


save('/data1/bliu/data/raw/CXT_ALL_norm_and_var_21dx10dt_Bingchen_qced.mat')


