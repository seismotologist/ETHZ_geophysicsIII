figure(1001); clf; hold on; grid on; box on;
xlm = [-117.8 -117.3];
ylm = [35.5 35.9];
plot_Cali_map
%plot_japan_map([26.5,48,127,148])
plot(ctlg.lon,ctlg.lat,'.k')
set(gca,'xlim',xlm,'ylim',ylm)

plot(ctlg.lon(i6p),ctlg.lat(i6p),'pk','markerFaceColor','r','markerSize',25)
plot(ctlg.lon(i5) ,ctlg.lat(i5) ,'pk','markerFaceColor','y','markerSize',12)
%plot_alternative_seismicit_map
title(tstring)

set(gcf,'PaperPositionMode','auto')
%print('-dpng',sprintf('%s_smap',fbasename))
