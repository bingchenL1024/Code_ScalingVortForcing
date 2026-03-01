% Bingchen Liu Jan 25, 2025
% This code get the nondimensional spectra (full)
% It normalize the spectra by its variance and ky by peak kym


clearvars -except expo





expo_name_temp = num2str(expo);
expo_name  = [expo_name_temp(1),'p',expo_name_temp(3:end)];

load(['/data1/bliu/data/Sky_withWBfit_10loc_qced_',expo_name])

for N = 1:24
    for xx=1:length(Skym2(1,:))
        Sky2_nond_kym_S0(N,xx,:) = Sky2_cutoff_runmean(N,xx,:).*wkym2(N,xx)./wfit2.So(N,xx);
        Sky3_nond_kym_S0(N,xx,:) = Sky3_cutoff_runmean(N,xx,:).*wkym3(N,xx)./wfit3.So(N,xx); 
        Sky4_nond_kym_S0(N,xx,:) = Sky4_cutoff_runmean(N,xx,:).*wkym4(N,xx)./wfit4.So(N,xx);

        ky2_nond(N,xx,:) = ky2_cutoff(N,xx,:)/kym2(N,xx);
        ky3_nond(N,xx,:) = ky3_cutoff(N,xx,:)/kym3(N,xx);
        ky4_nond(N,xx,:) = ky4_cutoff(N,xx,:)/kym4(N,xx);



    end 
end 

save(['/data1/bliu/data/Sky_nond_10loc_',expo_name])


