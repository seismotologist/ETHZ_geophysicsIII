make_time_vectors

%tx     = datetime(2019,07,06,16,0,0,'InputFormat','yy,mm,dd,HH,mm,ss');

% Hours leading up to MS; include entire sequence up to then in first bin;
% have last bin that includes entire sequence
tfirst = min(ctlg.t0);
tlast  = max(ctlg.t0);
dt     = minutes(30);
tt     = (ms.t0-hours(20):dt:ms.t0+dt)';
tt     = [tfirst; tt; tlast];
nt     = numel(tt)

