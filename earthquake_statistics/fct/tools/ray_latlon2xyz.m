function [x,y,z] = ray_latlon2xyz(lat,lon,alt,ref_lat,ref_lon,ref_alt,projection)

% For comments and tests, check test_ray_latlon2xyz.m

% CHANGES: I have slightly changed the original code to handle vectors of 
% coordinates as inputs, not just single points. Input coordinate vectors 
% must be of dimension <n by 1>, and reference coordinates must have same 
% dimensions. For this I had to change the order of the matrix
% multiplication for the enu-2-ned rotation.
% Moreover, in the 'flat' part, i have changed U = alt; to U = alt-ref_alt;
%                                               menandrin@gmail.com, 131125


% Input:    latitute/longitude              in [deg]
%           altitiudes                      in [m]
% Output:   distances wrt/ reference point  in [m]
%
% Unit check: [x,y,z] = ray_latlon2xyz(33,-122,1e4, 33.1,-122,0, 'spherical'); 
%             dx=1e4, dy=0, dz=-1e4
%             r = sqrt(dx^2+dy^2+dz^2) = sqrt(10^2+10^2) ~ 14,000m
%             r = sqrt(x^2+y^2+z^2)                      = 1.4940e+04

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function ray_latlon2xyz
%
% This function takes latitude and longitude coordinates and converts them
% into a NED (North [positve x], East [positive y], Down [positive z])
% cartesian coordinate system, for either a flat earth or a spherical earth. 
% In this tranformation, x, y, and z are in kilometers.
%
% Usage: [x,y,z]=ray_latlon2xyz(lat,lon,alt,ref_lat,ref_lon,ref_alt,projection)
%
% Inputs:
%   lat:            Input latitude coordinate
%   lon:            Input longitude coordinate
%   alt:            Input altitude (in kilometers)
%   ref_lat:        Reference latitude where x will be equal to 0
%   ref_lon:        Reference longitude where y will be equal to 0
%   ref_alt:        Reference altitude where z will be equal to 0
%   projection:     Desired projection type.  Valid options are 'flat' for a
%                   flat-earth projection, or 'spherical' for a
%                   spherical-earth projection.
%
% Outputs:
%   x:          X coordinate of input wrt/ reference point [m]
%   y:          Y coordinate of input wrt/ reference point [m]
%   z:          Z coordinate of input
%
% Author:
% Matt Gardine
% February 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(projection,'spherical')
    % Convert lat, lon, height in WGS84 to ECEF X,Y,Z
    %lat and long given in decimal degrees.
    lat     = lat/180*pi;       %converting to radians
    lon     = lon/180*pi;       %converting to radians
    ref_lat = ref_lat/180*pi;
    ref_lon = ref_lon/180*pi;
    a       = 6378137.0;        % earth semimajor axis in meters 
    f       = 1/298.257223563;  % reciprocal flattening 
    e2      = 2*f -f^2;         % eccentricity squared 
 
    chi = sqrt(1-e2*(sin(lat)).^2); 
    X = (a./chi +alt).*cos(lat).*cos(lon); 
    Y = (a./chi +alt).*cos(lat).*sin(lon); 
    Z = (a*(1-e2)./chi + alt).*sin(lat);
    
    % Convert reference lat, lon, altitude to ECEF X,Y,Z in [meters!]
    ref_chi = sqrt(1-e2*(sin(ref_lat)).^2); 
    Xr = (a./ref_chi +ref_alt).*cos(ref_lat).*cos(ref_lon); 
    Yr = (a./ref_chi +ref_alt).*cos(ref_lat).*sin(ref_lon); 
    Zr = (a*(1-e2)./ref_chi + ref_alt).*sin(ref_lat);
    
    % convert ECEF coordinates to local east, north, up (x,y,z) 
    phiP = atan2(Zr,sqrt(Xr.^2 + Yr.^2)); 
    lambda = atan2(Yr,Xr); 
 
    x1 = -sin(lambda).*(X-Xr) + cos(lambda).*(Y-Yr); 
    y1 = -sin(phiP).*cos(lambda).*(X-Xr) - sin(phiP).*sin(lambda).*(Y-Yr) + cos(phiP).*(Z-Zr); 
    z1 = cos(phiP).*cos(lambda).*(X-Xr) + cos(phiP).*sin(lambda).*(Y-Yr) + sin(phiP).*(Z-Zr);
  
    %enu = [x1; y1; z1];
    enu = [x1, y1, z1];
    % Rotation matrix to convert from ENU to NED coordinates
    rotation = [0 1 0; 1 0 0; 0 0 -1];
  
    % ned = rotation.*enu;
    ned = enu*rotation;
    x = ned(:,1);
    y = ned(:,2);
    z = ned(:,3);

    
    
elseif strcmp(projection,'flat')
    R = 6367000;
    %convert to radians
    lat = lat*pi/180;
    lon = lon*pi/180;
    ref_lat = ref_lat*pi/180;
    ref_lon = ref_lon*pi/180;

    
    E = (lon-ref_lon).*cos(ref_lat)*R;
    N = (lat-ref_lat)*R;
    U = alt-ref_alt;

    % Rotation matrix to convert from ENU to NED coordinates
    rotation = [0 1 0; 1 0 0; 0 0 -1];

    ned = [E,N,U]*rotation;
    x = ned(:,1);
    y = ned(:,2);
    z = ned(:,3);
end