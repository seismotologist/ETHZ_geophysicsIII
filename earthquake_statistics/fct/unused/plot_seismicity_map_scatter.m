figure(10011); clf; hold on; grid on; box on;

lnWidth = 1;
dlon    = 0.0005;
dlat    = 0.0005;

%hold on; imagesc(sentinel.lon,sentinel.lat,sentinel.A); axis xy

% % Historic seismicity
% try; plot(ctlgSCx.lon,ctlgSCx.lat,'.','color',[.7, .7, .7])
% catch
% end

% % Reference point
% try; plot(ctlgX.lon0,ctlgX.lat0,'or','markerSize',8,'lineWidth',2)
% catch
% end

plot_Cali_map
%plot_japan_map([26.5,48,127,148])

set(gca,'xlim',xlm,'ylim',ylm)
scatter(ctlgX.lon,ctlgX.lat,sz,clr,'filled','markerEdgeColor','k'); 
%scatter(ctlgX.lon,ctlgX.lat,sz,clr,'lineWidth',lnWidth); 
cb = colorbar;
cb.Label.String = clab;
title(tstring)
caxis(clm)
colormap(parula(nc)) 

plot(ms.lon,ms.lat,'pk','markerFaceColor','c','markerSize',25)
plot(fs.lon,fs.lat,'pk','markerFaceColor','c','markerSize',19)

% Plot details of foreshocks to M6.4
%plot(ctlgX.lon,ctlgX.lat,'-k');
txt = cellstr(num2str([1:numel(ctlgX.lat)]'));
%text(ctlgX.lon+dlon,ctlgX.lat+dlat,txt)


set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(gcf,'PaperPositionMode','auto')
%print('-dpng',sprintf('%s/smap2',fbasename))
