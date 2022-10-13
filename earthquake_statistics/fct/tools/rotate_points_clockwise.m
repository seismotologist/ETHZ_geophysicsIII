function [xr,yr] = rotate_points_clockwise(x,y,x0,y0,alpha)
% Rotate points [x,y] by angle alpha [°] clockwise around reference point
% [x0,y0]

R     = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
xyRot = [x-x0, y-y0]*R;
xr    = xyRot(:,1);
yr    = xyRot(:,2);
