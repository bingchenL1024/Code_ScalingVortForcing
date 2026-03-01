% Bingchen Liu Jan 14, 2025
% This code plot rmse VS diff expo and is used in 'master_analysisplot_expochoice.m'



load('/data1/bliu/data/WBfit_rmseVSexpo_10loc.mat')


figure()
plot(diffexpo,rmse_diffexp,'LineWidth',2.5)
xlabel('Exponential factor')
ylabel('RMSE')
xlim([diffexpo(1),diffexpo(end)])
niceplot_nobold(22)
set(gca,'XTick',diffexpo(1):0.05:diffexpo(end))




%% ====================== test for all RMSE def ===========================
figure()
subplot(141)
plot(diffexpo,rmse_diffexp,'LineWidth',2.5)
xlabel('Exponential factor')
ylabel('RMSE')
niceplot_nobold(20)
grid on 
set(gca,'XTick',diffexpo(1):0.05:diffexpo(end))


subplot(142)
plot(diffexpo,rmse_diffexp_log,'LineWidth',2.5)
xlabel('Exponential factor')
ylabel('Log RMSE')
niceplot_nobold(20)
grid on 
set(gca,'XTick',diffexpo(1):0.05:diffexpo(end))


subplot(143)
plot(diffexpo,rmse_diffexp_weight,'LineWidth',2.5)
xlabel('Exponential factor')
ylabel('RMSE with Weight')
niceplot_nobold(20)
grid on 
set(gca,'XTick',diffexpo(1):0.05:diffexpo(end))



subplot(144)
plot(diffexpo,rmse_diffexp_log_weight,'LineWidth',2.5)
xlabel('Exponential factor')
ylabel('Log RMSE with Weight')
niceplot_nobold(20)
grid on 
set(gca,'XTick',diffexpo(1):0.05:diffexpo(end))



