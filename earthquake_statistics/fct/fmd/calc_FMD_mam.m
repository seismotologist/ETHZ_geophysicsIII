function fmd = calc_FMD_mam(mVect,dm)
% Calculates the cumulative and non-cumulative frequency magnitude distribution 
%   for a given earthquake catalog; strongly modified from calc_FMD.m
%   mam, 190510

if nargin<2;  dm=0.1; end

% Determine the magnitude range
mmax = ceil(10 * max(mVect)) / 10;
mmin = floor(min(mVect));
if mmin > 0
  mmin = 0;
end

mEdges   = mmin:dm:mmax;
mCenters = mEdges(1:end-1)+dm/2;

% Count number per bin, and flip to start cumulative counts with high mags
counts    = fliplr(histcounts(mVect, mEdges));
cumcounts = cumsum(counts);
mCenters  = fliplr(mCenters);

fmd.inc      = counts;
fmd.cum      = cumcounts;
fmd.mCenters = mCenters;
fmd.mEdges   = mEdges;