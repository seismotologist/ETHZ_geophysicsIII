function catTM = combine_TM_cats(catTMdet,catTMtpl)
% Combine TM template catalog ("TMtpl") with TM detection catalog ("TMdet")
% . write coordinates of template catalog into detection catalog
% . add random scatter to locations
% . append template catalog at end of detection catalog
% . sort resulting catalog wrt/ origin time

catTMdet.params.tplFile = catTMtpl.params.rawfile_full;

ndet = numel(catTMdet.m);
ntpl = numel(catTMtpl.m);

% Scatter detections randomly around template location
hloc_std  = 0.0002;  % st dev of horizontal location perturbation in [deg]
vloc_std  = 20;      % st dev of vertical   location perturbation in [m]
dh_rnd    = hloc_std.*randn(ndet,1);
dv_rnd    = vloc_std.*randn(ndet,1);

catTMdet.lat = zeros(ndet,1);
catTMdet.lon = zeros(ndet,1);
catTMdet.alt = zeros(ndet,1);
for idet = 1:ndet
    itpl = catTMdet.template(idet);
    
    catTMdet.lat(idet) = catTMtpl.lat(itpl) + dh_rnd(idet);
    catTMdet.lon(idet) = catTMtpl.lon(itpl) + dh_rnd(idet);
    catTMdet.alt(idet) = catTMtpl.alt(itpl) + dv_rnd(idet);
end

% Append template events
catTMdet.template = [catTMdet.template; catTMtpl.template];
catTMdet.t0       = [catTMdet.t0;  catTMtpl.t0];
catTMdet.lat      = [catTMdet.lat; catTMtpl.lat];
catTMdet.lon      = [catTMdet.lon; catTMtpl.lon];
catTMdet.alt      = [catTMdet.alt; catTMtpl.alt];
catTMdet.m        = [catTMdet.m;   catTMtpl.m];
catTMdet.amp      = [catTMdet.amp; nan(ntpl,1)];   % no values for templates
catTMdet.ccc      = [catTMdet.ccc; nan(ntpl,1)];

ntot = size(catTMdet.m,1);
catTMdet.istemplate                 = false(ntot,1);
catTMdet.istemplate(end-ntpl+1:end) = true;


% Sort to have increasing time
catTM            = catTMdet;
[~,idx]          = sort(catTM.m);
catTM.template   = catTM.template(idx);
catTM.t0         = catTM.t0(idx);
catTM.lat        = catTM.lat(idx);
catTM.lon        = catTM.lon(idx);
catTM.alt        = catTM.alt(idx);
catTM.m          = catTM.m(idx);
catTM.amp        = catTM.amp(idx);
catTM.ccc        = catTM.ccc(idx);
catTM.istemplate = catTM.istemplate(idx);

catTM.str.title = 'TKTM merged';
catTM.str.short = 'TMmerged';    