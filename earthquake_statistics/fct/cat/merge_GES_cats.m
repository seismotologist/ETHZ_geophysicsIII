function cat = merge_GES_cats(cat,catAdd)

% Append 
nentries = structfun(@numel,cat);
neq      = max(nentries);
fdnames  = fieldnames(cat);
fdnames  = fdnames(nentries==neq);
nf       = numel(fdnames);

for ifd = 1:nf
    thisField       = fdnames{ifd};
	cat.(thisField) = [cat.(thisField); catAdd.(thisField)];
end