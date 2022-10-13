clear all
addpath(genpath(pwd))
set(0,'DefaultFigureWindowStyle','docked')




% Import Global Centroid Moment Tensor Catalogue ('gCMT'), one of the 
% most commonly used global earthquake catalogues
% The provided magnitudes are Moment Magnitudes 'Mw'
catname = 'dat/jan76_dec10_plusMonthlies_jan11_dec14_lat-90_90_lon-360_360.mat';
cat     = read_GMT_cat(catname);
cat


% Plot simple seismicity map
figure(101); clf; hold on; grid on; box on;
plot(cat.lon,cat.lat,'.k')

% Plot seismicity map with colour proporational to hypocentral depth
figure(102); clf; hold on; grid on; box on;
scatter(cat.lon,cat.lat,20,cat.depth,'filled')


% Plot seismicity map in 3D 
figure(103); clf; hold on; grid on; box on;
scatter3(cat.lon,cat.lat,cat.depth,4*cat.magnitude,cat.depth,'filled')
set(gca,'zdir','reverse','zlim',[0 1000])
cb = colorbar;
cb.Label.String = 'Hypocentral Depth [km]';
set(gca,'view',[-20 45])

% Zoom into Japan region
set(gca,'xlim',[125 155],'ylim',[25 55])


% Plot time versus magnitude
m = cat.magnitude;
mkSize = 1+(m-min(m)).^3;
figure(104); clf; hold on; grid on; box on;
scatter(cat.t0,cat.magnitude,mkSize,cat.magnitude,'filled','markerEdgeColor',[.4 .4 .4])
cb = colorbar;
cb.Label.String = 'Moment Magnitude';
cb.Label.FontSize = 12;
ylabel('Moment Magnitude')

% Repeat, but with colour proportional to depth
figure(105); clf; hold on; grid on; box on;
scatter(cat.t0,cat.magnitude,mkSize,cat.depth,'filled','markerEdgeColor',[.4 .4 .4])
cb = colorbar;
cb.Label.String = 'Hypocentral Depth [km]';
ylabel('Moment Magnitude')


% Cumulative moment 
cat.moment    = magnitude2moment(cat.magnitude);
cat.cummoment = cumsum(cat.moment);

figure(106); clf; hold on; grid on; box on; %plot(cat.t0,'-k');
plot(cat.t0,cat.cummoment,'-k');


% Cumulative seismic moment in bins of magnitude
dm     = .5;
medges = 4:dm:9.5;
nm     = numel(medges);
nbins  = nm-1;
M0     = zeros(nbins,1);

for ibin = 1:nbins
    mlo      = medges(ibin);
    mup      = medges(ibin+1);
    useme    = cat.magnitude>=mlo & cat.magnitude<mup;
    M0(ibin) = sum(cat.moment(useme));
end

figure(107); clf; hold on; grid on; box on;
mplot = medges(1:end-1)+dm/2;
bar(mplot,M0,'faceColor',[.2 .2 .2],'edgeColor',[.8 .8 .8])
xlabel('Moment Magnitude')
ylabel('Cumulative seismic moment [Nm]')