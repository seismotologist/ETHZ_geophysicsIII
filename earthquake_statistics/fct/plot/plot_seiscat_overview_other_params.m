

%set(fg.ax.smap,'zlim',[0 10])
%set(fg.ax.smap,'zlim',[5 10])

% Plot with c = dt rel to reference time
% ---------------------------------------
cat.plt.c.val = cat.dt_days;
cat.plt.c.lim = [min(cat.dt) max(cat.dt)]; 
cat.plt.c.lab = ['Days rel to ',datestr(ref.t)];
cat.plt.c.n   = 100;
fg             = plot_seiscat_overview(cat,1);
%print('-dpng',[cat.str.fbase,'/seiscat_overview_dtMS'],'-painters')
%print('-depsc2',[cat.str.fbase,'/seiscat_overview_dtMS'],'-painters')

set(fg.ax.smap,'zlim',[5 10])
set(gca,'view',[ 131 19])


% Plot with c = dist to MS
% ------------------------
cat.plt.c.val = cat.rhref;
cat.plt.c.lim =  [0 10]; 
cat.plt.c.lab = 'Distance to reference event [km]';            
fg             = plot_seiscat_overview(cat);

% Plot with c = azimuth wrt MS
% ----------------------------
cat.plt.c.val = cat.azi;
cat.plt.c.lim =  [0 360]; 
cat.plt.c.n   = 9;
cat.plt.c.lab = 'Azimuth [deg]';            
fg            = plot_seiscat_overview(cat);
