function [distance] = hypoDistance(lat1,lon1,alt1,lat2,lon2,alt2)

% Computes the distance between two points on a sphere, as specified
% with their lat/lon values [deg] and their depths [m]. I think it doesn't 
% matter whether alt1/2 are positive-up or -down, as long as both are 
% specified with the same convention.
%
% Input:  lat/lon    in [deg]
%         alt/depth  in [m]
% Output: distance   in [m]
%
% menandrin@gmail.com, 130528

[x,y,z]  = ray_latlon2xyz(lat1,lon1,alt1,lat2,lon2,alt2,'spherical');    % Postion wrt/ reference point in [m]
distance = sqrt(x.^2 + y.^2 + z.^2);                                     % Distance in [m]















% Notes -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
% Alternative algorithm for at surface of earth. Claims to have an accuracy
% of several milimeters:
%eD1        = vdist(lat1,lon1,lat2,lon2)                         % Distance in [m]


% % Test importance of reference point
% [x1,y1,z1] = ray_latlon2xyz_corr(lat1,lon1,alt1,lat1,lon1,alt1,'spherical');  % Postion wrt/ reference point in [m]
% [x2,y2,z2] = ray_latlon2xyz_corr(lat2,lon2,alt2,lat1,lon1,alt1,'spherical');
% distance2   = sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2);                % Distance in [m]
% distance2   = distance2/1000;                                          % Distance in [km]
% 
% 
% difference = distance - distance2
% 
% BOTTOMLINE: choice of reference point does not make a large difference.
