function matches = find_cat_overlap(cat1,cat2,dtmax,dmmax,drmax)


neq1 = numel(cat1.m);
neq2 = numel(cat2.m);

matches.i1 = {};
matches.i2 = {};
imatch     = 0;

for ieq1 = 1:neq1
    
    dm = abs(cat1.m (ieq1) - cat2.m);
    dt = abs(cat1.t0(ieq1) - cat2.t0);
    dr = sqrt( (cat1.x(ieq1)-cat2.x).^2 + (cat1.y(ieq1)-cat2.y).^2 + (cat1.z(ieq1)-cat2.z).^2);
    
    idx = find( dm<=dmmax & dt<=dtmax & dr<=drmax );
    if ~isempty(idx)
        imatch = imatch+1;
        matches.i1{imatch} = ieq1;
        matches.i2{imatch} = idx;
    end
end

fprintf(1,sprintf('%i matches found.\n',imatch))

matches.dtmax = dtmax;
matches.dmmax = dmmax;
matches.drmax = drmax;