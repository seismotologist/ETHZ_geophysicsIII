function cat = read_eqcat_Bedretto(catFullName,catType)
% Function to read various seismicity catalog formats
% For each catalog type you should provide an example file
%
% Make sure to adhere to depth naming convention
%     alt = altitude above sea level in m
%     dep = depth below sea level in m
%     z   = depth in local CS with z = CS origin depth at tunnel level (alt=1480 (?)) in [m]


% Catalog Type List -------------------------------------------------------
% 'TKTMdet_2105'    TK's TM catalogs, first provided for Bedretto on 210512
% 'TKTMtpl_2105'    TK's 5 templates used to find TMs
% 'ges_2105'        Catalogs provided by Ben Dyer on 210513
% 'tmpGES'          temporary GES format for list of largest events
%                   LV has csv file, should be merged with ges_2105 type
% 'SED_2105'        SED Datenbank Auszug
% ...
% -------------------------------------------------------------------------

    
tmp = regexp(catFullName,'/','split');
cat.params.rawfile      = tmp{end};
cat.params.rawfile_full = catFullName;
cat.params.cattype      = catType;


% Read file into array of lines
fid    = fopen(catFullName);
StrRay = fscanf(fid,'%c');
fclose(fid);

eolLim      = '\r?\n';
LinePattern = ['[^\r\n]*', eolLim];
thelines    = regexp(StrRay,LinePattern,'match');
nlines      = numel(thelines);


    
% .........................................................................
% TMTK: xx
% e.g.: dat/tk/detection-catalog-combo_Mag.dat
if strcmp(catType,'TKTMdet_2105')
    neq = nlines-1;
    cat.header = thelines{1}(1:end-2);
    cat.str.title = 'TKTM detections';
    cat.str.short = 'TMdet';
    
    cat.t0       = cell(neq,1);
    cat.amp      = zeros(neq,1);
    cat.m        = zeros(neq,1);
    cat.template = zeros(neq,1);
    cat.ccc      = zeros(neq,1);
    
    for ieq = 1:neq
        
        iline    = ieq+1;
        thisline = thelines{iline}(1:end-2);
        fields   = regexp(thisline,'\, ','split');
        
        cat.t0      {ieq} = datetime(fields{1},'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z');
        cat.amp     (ieq) = str2double(fields{2});
        cat.m       (ieq) = str2double(fields{3});
        cat.template(ieq) = str2double(fields{4});
        cat.ccc     (ieq) = str2double(fields{5});
    end
    cat.t0 = [cat.t0{:}]';
    
    

% .........................................................................
% e.g.: dat/tk/templates_mam.dat
elseif strcmp(catType,'TKTMtpl_2105')
    neq = nlines-1;
    cat.header = thelines{1}(1:end-2);
    cat.str.title = 'TKTM templates';
    cat.str.short = 'TMtpl';
    
    cat.template = zeros(neq,1);
    cat.t0       = cell(neq,1);
    cat.lat      = zeros(neq,1);
    cat.lon      = zeros(neq,1);
    cat.dep      = zeros(neq,1);
    cat.m        = zeros(neq,1);
    
    for ieq = 1:neq
        
        iline    = ieq+1;
        thisline = thelines{iline}(1:end-1);
        fields   = regexp(thisline,'[ \t]+','split');
        
        % Origin date & time
        cat.template(ieq) = str2num(fields{1});
        
        datfields   = regexp(fields{2},'/','split');
        dy          = str2double(datfields{1});
        mo          = str2double(datfields{2});
        yr          = str2double(datfields{3});
        
        timfields   = regexp(fields{3},':','split');
        hr          = str2double(timfields{1});
        mn          = str2double(timfields{2});
        sc          = str2double(timfields{3});
        cat.t0{ieq} = datetime(yr,mo,dy,hr,mn,sc);
        
        
        cat.lat(ieq) = str2double(strrep(fields{4},',','.'));
        cat.lon(ieq) = str2double(strrep(fields{5},',','.'));
        cat.dep(ieq) = str2double(strrep(fields{6},',','.'))*1000;
        cat.m  (ieq) = str2double(strrep(fields{11},',','.'));
    end
    cat.t0  = [cat.t0{:}]';
    cat.alt = -cat.dep;
    
% .........................................................................
% GES catalogs: xx
% '~/data/project/bedretto/seismicity2105/ges/202105/ST1MonitoringInt\ 6\ Stim.csv';
elseif strcmp(catType,'ges_2105')

    neq        = nlines-1;
    cat.header = thelines{1}(1:end-2);
    cat.params.mtype = 'Moment Magnitude';
    
    cat.source    = zeros(neq,1);
    cat.t0        = cell(neq,1);
    cat.ttrig     = cell(neq,1);
    cat.profile   = cell(neq,1);
    cat.status    = zeros(neq,1);
    cat.cluster   = zeros(neq,1);
    cat.y         = zeros(neq,1);
    cat.x         = zeros(neq,1);
    cat.z         = zeros(neq,1);
    cat.m         = zeros(neq,1);
    cat.pgv       = zeros(neq,1);
    cat.stage     = zeros(neq,1);
    cat.SNR_p     = zeros(neq,1);
    cat.SNR_s     = zeros(neq,1);
    cat.quality   = zeros(neq,1);
    cat.error     = zeros(neq,1);
    cat.location  = cell(neq,1);
    cat.rms_noise = zeros(neq,1);
        
    
    for ieq = 1:neq
       
        iline    = ieq+1;
        thisline = thelines{iline}(1:end-2);
        fields   = regexp(thisline,'\, ','split');
        
        cat.source (ieq) = str2double(fields{1});
        
        % Triggering date & time
        datfields   = regexp(fields{2},'/','split');
        dy          = str2double(datfields{1});
        mo          = str2double(datfields{2});
        yr          = str2double(datfields{3});
        
        timfields   = regexp(fields{3},':','split');
        hr          = str2double(timfields{1});
        mn          = str2double(timfields{2});
        sc          = str2double(timfields{3});
        cat.ttrig{ieq} = datetime(yr,mo,dy,hr,mn,sc);
        
        % Origin date & time
        datfields   = regexp(fields{4},'/','split');
        dy          = str2double(datfields{1});
        mo          = str2double(datfields{2});
        yr          = str2double(datfields{3});
        
        timfields   = regexp(fields{5},':','split');
        hr          = str2double(timfields{1});
        mn          = str2double(timfields{2});
        sc          = str2double(timfields{3});
        cat.t0{ieq} = datetime(yr,mo,dy,hr,mn,sc);
        
        cat.profile{ieq}   = fields{6};
        cat.status(ieq)    = str2double(fields{7});
        cat.cluster(ieq)   = str2double(fields{8});
        
        cat.y(ieq)         = str2double(fields{9});
        cat.x(ieq)         = str2double(fields{10});
        cat.z(ieq)         = str2double(fields{11});

        cat.m(ieq)        = str2double(fields{12});
        cat.pgv(ieq)       = str2double(fields{13});
        cat.stage(ieq)     = str2double(fields{14});
        cat.SNR_p(ieq)     = str2double(fields{15});
        cat.SNR_s(ieq)     = str2double(fields{16});
        
        cat.quality(ieq)   = str2double(fields{17});
        cat.error(ieq)     = str2double(fields{18});
        cat.location{ieq}  = fields{19};
        cat.rms_noise(ieq) = str2double(fields{20});
        
    end
    cat.t0           = [cat.t0{:}]';
    cat.ttrig        = [cat.ttrig{:}]';
    cat.m(cat.m<-10) = nan;
    cat.alt          = 1480 - cat.z;
    
    isZilt = cat.x==0 & cat.y==0 & cat.z==0;
    cat.x  (isZilt) = nan;
    cat.y  (isZilt) = nan;
    cat.z  (isZilt) = nan;
    cat.alt(isZilt) = nan;
    cat.pgv(isZilt) = nan;



% .........................................................................
% tmpGES
% '~/data/project/bedretto/seismicity2105/ges/202105/ST1MonitoringInt\ 6\ Stim.csv';
elseif strcmp(catType,'tmpGES')

    neq        = nlines-1;
    cat.header = thelines{1}(1:end-2);
    cat.params.mtype = 'Moment Magnitude';
    
    cat.source    = zeros(neq,1);
    cat.t0        = cell(neq,1);
    cat.ttrig     = cell(neq,1);
    cat.profile   = cell(neq,1);
    cat.status    = zeros(neq,1);
    cat.cluster   = zeros(neq,1);
    cat.y         = zeros(neq,1);
    cat.x         = zeros(neq,1);
    cat.z         = zeros(neq,1);
    cat.m         = zeros(neq,1);
    cat.pgv       = zeros(neq,1);
    cat.stage     = zeros(neq,1);
    cat.SNR_p     = zeros(neq,1);
    cat.SNR_s     = zeros(neq,1);
    cat.quality   = zeros(neq,1);
    cat.error     = zeros(neq,1);
    cat.location  = cell(neq,1);
    cat.rms_noise = zeros(neq,1);
        
    
    for ieq = 1:neq
       
        iline    = ieq+1;
        thisline = thelines{iline}(1:end-2);
        fields   = regexp(thisline,'[,]+','split');
        
        cat.source (ieq) = str2double(fields{1});
        
        % Triggering date & time
        datfields   = regexp(fields{2},'/','split');
        dy          = str2double(datfields{1});
        mo          = str2double(datfields{2});
        yr          = str2double(datfields{3});
        
        timfields   = regexp(fields{3},':','split');
        hr          = str2double(timfields{1});
        mn          = str2double(timfields{2});
        sc          = str2double(timfields{3});
        cat.ttrig{ieq} = datetime(yr,mo,dy,hr,mn,sc);
        
        % Origin date & time
        datfields   = regexp(fields{4},'/','split');
        dy          = str2double(datfields{1});
        mo          = str2double(datfields{2});
        yr          = str2double(datfields{3});
        
        timfields   = regexp(fields{5},':','split');
        hr          = str2double(timfields{1});
        mn          = str2double(timfields{2});
        sc          = str2double(timfields{3});
        cat.t0{ieq} = datetime(yr,mo,dy,hr,mn,sc);
        
        cat.profile{ieq}   = fields{6};
        cat.status(ieq)    = str2double(fields{7});
        cat.cluster(ieq)   = str2double(fields{8});
        
        cat.y(ieq)         = str2double(fields{9});
        cat.x(ieq)         = str2double(fields{10});
        cat.z(ieq)         = str2double(fields{11});

        cat.m(ieq)        = str2double(fields{12});
        cat.pgv(ieq)       = str2double(fields{13});
        cat.stage(ieq)     = str2double(fields{14});
        cat.SNR_p(ieq)     = str2double(fields{15});
        cat.SNR_s(ieq)     = str2double(fields{16});
        
        cat.quality(ieq)   = str2double(fields{17});
        cat.error(ieq)     = str2double(fields{18});
        cat.location{ieq}  = fields{19};
        cat.rms_noise(ieq) = str2double(fields{20});
        
    end
    cat.t0           = [cat.t0{:}]';
    cat.ttrig        = [cat.ttrig{:}]';
    cat.m(cat.m<-10) = nan;
    cat.alt          = 1480 - cat.z;
    
    isZilt = cat.x==0 & cat.y==0 & cat.z==0;
    cat.x  (isZilt) = nan;
    cat.y  (isZilt) = nan;
    cat.z  (isZilt) = nan;
    cat.alt(isZilt) = nan;
    cat.pgv(isZilt) = nan;
   
    
% .........................................................................
% SED Datenbank Auszug
% e.g.: 'dat/tk/Bedretto_SEDevents.csv'
elseif strcmp(catType,'SED_2105')
    
    
    neq        = nlines-2;
    cat.header1 = thelines{1}(1:end-1);
    cat.header2 = thelines{2}(1:end-1);
    
    cat.t0  = cell(neq,1);
    cat.lat = zeros(neq,1);
    cat.lon = zeros(neq,1);
    cat.dep = zeros(neq,1);
    cat.m   = zeros(neq,1);

    for ieq = 1:neq
        
        iline    = ieq+2;
        thisline = thelines{iline}(1:end-2);
        fields   = regexp(thisline,'[,]+','split');
        
        cat.t0{ieq}  = datetime(fields{2}(2:end-1), 'InputFormat','yyyy-MM-dd HH:mm:ss');
        cat.lat(ieq) = str2double(fields{3}(2:end-1));
        cat.lon(ieq) = str2double(fields{4}(2:end-1));
        cat.dep(ieq) = str2double(fields{5}(2:end-1))*1000;
        cat.m  (ieq) = str2double(fields{10}(2:end-1));
    end
    cat.t0  = [cat.t0{:}]';
    cat.alt = -cat.dep;
end