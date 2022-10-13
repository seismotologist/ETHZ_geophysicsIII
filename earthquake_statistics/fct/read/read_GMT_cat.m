function cat  = read_GMT_cat(catname)
load(catname);

% Rename fields
cat.lat       = CMT.lat;
cat.lon       = CMT.lon;
cat.depth     = CMT.depth;
cat.magnitude = CMT.Mw;


neq    = numel(cat.lat);
cat.t0 = NaT(neq,1); 
c      = 0;
keepme = true(neq,1);
for ieq = 1:neq
    t0str = [CMT.date{ieq},' ',CMT.t0{ieq}];
    if strcmp(CMT.t0{ieq}(4:5),'60') |strcmp(CMT.t0{ieq}(7:8),'60')
        keepme(ieq) = false;
    else
        cat.t0(ieq) = datetime(t0str,'InputFormat','yyyy/MM/dd HH:mm:ss.S');
    end
end
fprintf(1,sprintf('Skipped %i quakes with problematic origin times.\n',sum(~keepme)))

cat.lat       = cat.lat(keepme);
cat.lon       = cat.lon(keepme);
cat.depth     = cat.depth(keepme);
cat.magnitude = cat.magnitude(keepme);
cat.t0        = cat.t0(keepme);

% Sort catalogue so that times are strictly increasing
[val,idx]     = sort(cat.t0);
cat.lat       = cat.lat(idx);
cat.lon       = cat.lon(idx);
cat.depth     = cat.depth(idx);
cat.magnitude = cat.magnitude(idx);
cat.t0        = cat.t0(idx);