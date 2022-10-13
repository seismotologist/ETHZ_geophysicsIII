function cat = select_subcat(cat,useme)

nentries = structfun(@numel,cat);
neq      = max(nentries);
fdnames  = fieldnames(cat);
fdnames  = fdnames(nentries==neq);
nf       = numel(fdnames);

for ifd = 1:nf
    thisField       = fdnames{ifd};
	cat.(thisField) = cat.(thisField)(useme);
end