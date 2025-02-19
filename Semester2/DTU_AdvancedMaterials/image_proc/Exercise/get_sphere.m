function [vol_sphere, interface_area] = get_sphere(r)

%% generate an artifical sphere with radius r
sl = 2*r+5; % a cube with side length 2*r
[col, row, depth] = meshgrid(1:sl,1:sl,1:sl); % [column row layer]
cen = ones(1,3)*(round(sl)/2)+rand(1,3); % center of the sphere in row, col, layer coordinates
vol_sphere = (row-cen(1)).^2 + (col -cen(2)).^2 + (depth - cen(3)).^2 < r^2; % the segmented sphere

%% the theoretical surface area of the underlying structure.
interface_area = 4*pi*r^2;
end