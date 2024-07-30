function total_area = get_interface_area(vol,voxel_size)

iso_level = 0.5;
fv = isosurface(vol,iso_level); % polygonizes the iso_level

%% transform the vertex coordinates into physical units.

%% Loop over all triangles and sum up the total area

end