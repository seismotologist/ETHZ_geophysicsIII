figure(1006); clf; 

subplot(1,7,1:5); hold on; box on; grid on;
scatter(x,y,s,clr,'filled','markerEdgeColor','k')
%scatter(x,y,s,clr,'filled','markerEdgeColor','none')
caxis(clm)
posbak = get(gca,'position');
%ylm    = get(gca,'ylim');
set(gca,'ylim',ylm)
colormap(parula(nc))
cb = colorbar;
cb.Label.String = clab; xlabel(xlab); ylabel(ylab); title(tstring)
%set(gca,'ydir','reverse','position',posbak)
%set(gca,'position',posbak)

subplot(1,7,7); hold on; box on; grid on;
histogram(y,0:20,'faceColor',cgrey,'edgeColor','w')
view([90 -90])
%set(gca,'xdir','reverse','xlim',ylm)
ylabel('No. of cases')

set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(gcf,'PaperPositionMode','auto')
%fname = '~/programs/seismo/fig/i39/specialEQs/190704_Mw7p1_SearlesValleyCA/seismicity/stem/new/stem_depth_vs_yr';
fname = '~/programs/seismo/fig/i39/specialEQs/190704_Mw7p1_SearlesValleyCA/seismicity/stem/new/stem_depth_vs_yr_ZRTM';
print('-dpng',fname)
%print('-dpng',sprintf('%s/stem_depth2',fbasename))
