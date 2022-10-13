function [hf,figName] = plot_2cats_stem_plot(cat1,cat2)


cgray = [.4 .4 .4];

mmin    = -3.5;
mmax    = max([cat1.m; cat2.m]);
cat1.dm = cat1.m-mmin+.1; 
cat2.dm = cat2.m-mmin+.1; 

x1.val = cat1.t0;
x2.val = cat2.t0;
x1.lab = 'Date';

y1.val = cat1.m;
y2.val = cat2.m;
y1.lab = 'Magnitude^*';

c1.val = y1.val;
c2.val = y2.val;
c1.lim = [mmin mmax];
c1.map = parula(12);
c1.lab = y1.lab;

v = 10;
w = 1.5;
s1.val = v*cat1.dm.^w;
s2.val = v*cat2.dm.^w;


hf  = figure(104); clf; hold on; grid on; box on;
hs1 = scatter(x1.val,y1.val,s1.val,c1.val,'o','filled','markerEdgeColor',cgray);
hs2 = scatter(x2.val,y2.val,s2.val,c2.val,'v','filled','markerEdgeColor',cgray);
xlabel(x1.lab)
ylabel(y1.lab)
title([cat1.str.title,' vs ',cat2.str.title])

caxis(c1.lim)
colormap(c1.map)
cb = colorbar;
cb.Label.String = c1.lab; 

hl = legend([hs1,hs2],cat1.str.title,cat2.str.title);
set(hl,'location','northWest')

figName = ['fig/new/stem_',cat1.str.short,'_vs_',cat2.str.short];