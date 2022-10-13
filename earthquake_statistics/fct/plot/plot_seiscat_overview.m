function fig = plot_seiscat_overview(cat,map3d)
% Plot general overview plots for a seismicity catalog

fig.hf      = figure(1212); clf;
fig.ax.smap = subplot(4,3,[1,2,4,5]);  hold on; grid on; box on;   % Seismicity map (3d)
fig.ax.sfmd = subplot(4,3,[3,6]);      hold on; grid on; box on;   % FMD
fig.ax.shm  = subplot(4,3,9);          hold on; grid on; box on;   % Magnitude histogram
fig.ax.shz  = subplot(4,3,12);         hold on; grid on; box on;   % Depth histogram
fig.ax.st1  = subplot(4,3,7:8);        hold on; grid on; box on;   % Stem plot coloured by depth
fig.ax.st2  = subplot(4,3,10:11);      hold on; grid on; box on;   % Stem plot coloured by depth
%shr  = subplot(4,3,12);          hold on; grid on; box on;   % Inter-event distances histogram

%iref = cat.refeq.idx;

% Plot parameters
xp = cat.plt.x;
yp = cat.plt.y;
zp = cat.plt.z;
sp = cat.plt.s;
cp = cat.plt.c;
mp = cat.plt.m;

iref = cat.ref.i;

%mrange = [min(cat.m)-.1 max(cat.m)+.2];

ftSmall    = 8;
cgrey      = [.3 .3 .3];
cgreyLight = [.5 .5 .5];
mkeclr     = cgreyLight;


% % Colouramp
%clr.brb = Black_rainbow; %nc = size(clr.brb.black_rainbow,1);  >> has 64 entries
%cmap    = clr.brb.black_rainbow_plus;
cmap = flipud(parula(cp.n));
%cmap    = parula(cp.n);




%% Plot seismicity map 
subplot(fig.ax.smap)
set(gca,'xlim',xp.lim,'ylim',yp.lim)
%fig.hf = plot_BULG_3D_model_tunnel_and_boreholes_210515;

if ~map3d; scatter( cat.x, cat.y,        sp.val, cp.val, 'filled','markerEdgeColor',mkeclr); 
else       scatter3(cat.x, cat.y, cat.z, sp.val, cp.val, 'filled','markerEdgeColor',mkeclr);
           set(gca,'zlim',zp.lim,'zdir','reverse')
end

if ~isempty(iref)
    if ~map3d; scatter( cat.x(iref),cat.y(iref),            sp.val(iref),cp.val(iref),'filled','markerEdgeColor','r','lineWidth',2);
    else       scatter3(cat.x(iref),cat.y(iref),cat.z(iref),sp.val(iref),cp.val(iref),'filled','markerEdgeColor','r','lineWidth',2); 
    end
end

cb = colorbar;
cb.Label.String = cp.lab;
title(cat.str.title,'fontWeight','normal')
caxis(cp.lim)
colormap(cmap) 

% Annotate individual events
%txt = cellstr(num2str([1:numel(cat.y)]'));
%text(cat.x+dlon,cat.y+dlat,txt)



%% Plot FMD
subplot(fig.ax.sfmd)
fmd = calc_FMD_mam(cat.m,0.1);

li = plot(fmd.mCenters,fmd.inc,'o','markerFaceColor',cgreyLight,'markerEdgeColor',cgrey);
lc = plot(fmd.mCenters,fmd.cum,'r');
set(gca,'yscale','log','ylim',[.9 1.2*max(fmd.cum)],'YAxisLocation','right', ...
    'xtick',-9:.5:9,'xlim',mp.lim)
legend([lc,li],'cum. FMD','inc. FMD','fontSize',ftSmall,'color','none','box','off')
ylabel('No. of cases')
xlabel('Magnitude')


%% Plot magnitude histogram
subplot(fig.ax.shm)
histogram(cat.m,floor(min(cat.m)):.1:ceil(max(cat.m)),'faceColor',cgrey,'edgeColor','w')
set(gca,'YAxisLocation','right','yscale','log')
xlabel('Magnitude')
ylabel('No. of cases')
ylm = get(gca,'ylim')
ylm(1) = .2;
set(gca,'ylim',ylm)
set(gca,'xtick',-9:9)


%% Plot depth histogram
subplot(fig.ax.shz)
histogram(cat.z,floor(min(cat.z)):10:ceil(max(cat.z)),'faceColor',cgrey,'edgeColor','w')
set(gca,'YAxisLocation','right')
xlabel('Hypocentral depth [m]')
ylabel('No. of cases')



%% Stem plot 1 (c = same as in smap)
subplot(fig.ax.st1)
%stem(    cat.t0,      cat.m,                                                'MarkerSize',.1,'color',cgrey)
scatter3(cat.t0,      cat.m,      cat.z,      sp.val,cp.val,            'filled','markerEdgeColor',cgrey)
%scatter3(cat.t0(iref),cat.m(iref),cat.z(iref),sp.val(iref),cp.val(iref),'markerEdgeColor','r','lineWidth',2)
set(gca,'zdir','reverse','ylim',cat.plt.m.lim)
ylabel('Magnitude')
caxis(cp.lim)



%% Stem plot 2 (c = same as in smap)
subplot(fig.ax.st2)
scatter(cat.t0      ,cat.z      ,sp.val      ,cp.val,'filled','markerEdgeColor',cgrey)
%scatter(cat.t0(iref),cat.z(iref),sp.val(iref),cp.val(iref),'markerEdgeColor','r','lineWidth',2)
ylabel('Hypocentral Depth [km]')
caxis(cp.lim)
set(gca,'Ydir','reverse','ylim',zp.lim)

linkaxes([fig.ax.st1,fig.ax.st2],'x');