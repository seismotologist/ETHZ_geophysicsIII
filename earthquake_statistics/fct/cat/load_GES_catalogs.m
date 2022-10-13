function cat = load_GES_catalogs
% mameier:dat/ges$ find . -iname *.csv
gesFileList = {'dat/ges/202011/ST2EventFilesClustered/Phase5Nov23Phase 5 Monitor.csv'; ...
               'dat/ges/202011/ST2EventFilesClustered/Phase3Nov17Phase 3 Monitor.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase7Nov29Phase 7.csv'; ... 
               'dat/ges/./202011/ST2EventFilesClustered/Phase1Nov11-VENPhase 1 Monitor.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase2Nov13Monitor 15.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase2Nov13Monitor 14.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase2Nov13Monitor 13.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase6Nov27Stage 6.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase4Nov21Phase 4 Monitor.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase8Nov30Phase 8.csv'; ... 
               'dat/ges/202011/ST2EventFilesClustered/Phase9Nov30Phase 9.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 2 Hydro Test.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 6 Stim.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 6 Hydro Test.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 4 Stim.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 1&2 Stim.csv'; ... 
               'dat/ges/202105/ST1MonitoringInt 4 HydroTest.csv'};

nfiles = numel(gesFileList);
fprintf(1,sprintf('Loading %i GES catalogs .. \n',nfiles))

cat = read_eqcat_Bedretto(gesFileList{1},'ges_2105');
for ifile = 2:nfiles
    cat_add = read_eqcat_Bedretto(gesFileList{ifile},'ges_2105');
    cat     = merge_GES_cats(cat,cat_add);
end

cat.params.gesFileList = gesFileList;
cat.str.title = 'GES merged';
cat.str.short = 'GESmerged';




% Header definitions from file dat/ges/202002/Zones2and6and7FinalLocations.xls   
% ----------------------------------------------------------------------------
% note: not sure if this is valid for all events or just those in
% dat/ges/202002/ directory

% Sequence		A sequential counter for sorting purposes only
% Source		The Source number in Divine. This is in the range 1, number of sources within each microseimic group
% Date          Time   		Date and time of the event
% Profile  		Trigger profile name. We only used one profile ie one set of trigger parameters
% Status		The nature of the event location. 2 is a located microseismic event, 4 = a located check shot ie an event with a known location
% Cluster		The cluster number the event belongs to. Clusters are numbered from 1. An event that is not assigned to a cluster has a number of 0
% Y             The coordinates in the local reference frame. In this case it is the tunnel coordinate system with an origin at TM2000
% X             "
% Depth         "
% momMag		Time domain magnitude. Here derived from the S wave at CB2 geophone groups 3 and 4, the deepest groups that were closest to the events
% PGV           The peak ground velocity. Only the CB2 geophone string was monitored for PGV. The units are um/s
% Stage         A counter from 1 to the number of microseismic groups defined in the projject. Stage 3 = zone 2, Stage 7 = Zone 6 and Stage 8 = Zone 7
% P S/N         The ratio of the peak P wave trace value to the rms noise level prior to the P pick or time zero if there is no P pick
% S S/N         The ratio of the peak S wave trace value to the rms noise level prior to the P pick or time zero if there is no P pick
% Quality		A dimensionless measure of the event quality. It is the ratio of the Bootstrap stack amplitude to the long term stack amplitude. Usually in the range 2 to 10. Higher values indicate a more reliable event location
% Error         The maximum error in the event location that is consistent with the traveltime pick and hodogram angle misfits. This can vary a lot due to the limited hodogram accuracy
% Location		How the event was located. L2 msmx is a visually checked L2 minimisation. Boot msmx is an automatic Bootstrap location. L2 check is a visually checked L2 minimisation location of a check shot
% rms Noise		The average rms trace noise level in uV over all the trace data. NB in this case the packer geophones trace amplitudes were artificailly scaled down by a factor of 1e6 in order to measure the noise on the Sercel geophones in CB2 and CB3
% 		
% 		Boot msmx are for approximate magnitude use only. The events could not be reliably located and so were constrained to a small region around the stimulation zones.