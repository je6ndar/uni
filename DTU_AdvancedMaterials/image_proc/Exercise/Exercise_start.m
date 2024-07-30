%% exercise: Measuring the interface area of a structure in a 3D image.
% see the Exercise - Quatitative 3D imaging.pdf for instructions.

%% load in the data
if ~exist('vol','var')

% select the folder where the data is stored (the freezecast_reduced_8bit folder)
load_path = uigetdir([],'freezecast_reduced_8bit');

vol = load_image_stack(load_path,'slice_','.tif');

% reduce the size of the volume if you run out of memory or if things take
% too long to run. The full dataset is 500x500x500 voxels.
%vol = vol(:,:,:);

% convert to double precision floating point. This is only needed because
% Matlab likes working with double precision numbers.
vol = double(vol);
end

% see the size and type of data in the 3D image 'vol'.
whos vol

% show slice 250 from the dataset
figure, imagesc(vol(:,:,250)), colormap gray, axis image, title('raw image')

% show a histogram of image intensities with 300 bins
figure, histogram(vol(:),300), title('raw image histogram')

%% Filter the data

% HINTS
help medfilt3

filtered_vol = medfilt3(vol)

%figure, volshow(filtered_vol)
figure, imagesc(filtered_vol(:,:,250)), colormap gray, axis image, title('filtered image')

%% Segmentation

% HINTS:
% if you hower your mouse over a figure some interaction options will
% appear above the figure. The Data tips tools is useful for reading off
% intensity values from a histogram.
A = [1 4 6; 3 7 4; 2 4 7]
A_seg = A > 5 % this also works with N-D matrices
% A_seg is now of class logical (0s and 1s)
whos A_seg

th_top = median(filtered_vol(1:6,295:300,250), "all");
th_down = median(filtered_vol(145:150,175:180,250), "all");

figure, imagesc(filtered_vol(280:285,10:15,250)), colormap gray, axis image, title('image 1')
figure, imagesc(filtered_vol(10:15,10:15,250)), colormap gray, axis image, title('image 2')
figure, imagesc(filtered_vol(10:15,280:285,250)), colormap gray, axis image, title('image 3')
%% Calculate the phase fractions

% HINTS:
% Remember that the segmentation only contains 0s and 1s, representing the
% pore and the solid phase.
help sum
help numel
help not % or (~). Logical not operator, could be used to swap the phase represented by 1s in the segmentation 
A = [0 1]
~A

%% Polygonizing the interface

% since this can take some time to calculate we start by reducing the
% volume size by only including every second, row, column and slice.
vol_seg_reduced = vol_seg(1:2:end,1:2:end,1:2:end); % here I am assuming that your segmentation is stored in the variable vol_seg
whos vol_seg_reduced % to print the new dimensions of the volume
figure, imagesc(vol_seg_reduced(:,:,125))

% polygonize the 0.5 iso level in the segmented image.
fv = isosurface(vol_seg_reduced,0.5);

% the output is a Matlab data structure known as a struct that cotains the
% vertex positions and polygon definitions of all the triangles that
% describe the interface. This way of storing triangle information is known as an
% indexed face set.
vertices = fv.vertices; % or points
faces = fv.faces; % or triangles
whos vertices
whos faces

% each row contains the 3 coordinates for one vertex.
number_of_vertices = size(fv.vertices,1)

% each row defines a triangle. The three values represent the location (index) of the vertex in the vertex list (the row number)
number_faces = size(fv.faces,1)

% this way of storing triangle data saves space as we only need to store
% the coordinate of each vertex once, even if its shared by several faces.

%% make a 3D plot of the interfaces


figure; p = patch(fv); % draws the polygons defined in fv

% we close the parts of the structures that intersect the volume edges for
% a better visual interpretation
p_caps = patch(isocaps(vol_seg_reduced,0.5)); 
p.FaceColor = 'red';
p.EdgeColor = 'none';
p_caps.FaceColor = 'red';
p_caps.EdgeColor = 'none';
daspect([1,1,1])
view(3); axis tight
camlight
lighting gouraud

%% Calculate the interface area of a segmentation.
% the voxel size of the dataset is
voxel_size = [1.11383 1.11383 1.11383]; % [um]

% HINTS:
% - calculate the area of each triangle and sum over all triangles in a for loop.
help cross
help norm
% - start testing with one triangle and implement the loop once that works.

% For the first triangle (as illustration)
% the vertex indices of the three vertices of the first triangle (or face) is the first row of
% indicies in fv.faces.
face1 = fv.faces(1,:);
% the corresponding coordinates are stored on the corresponding rows of
% fv.vertices.
tcoords = fv.vertices(face1,:); % each row of tcoords is now a vertex position in the triangle.

% matlab for-loop example
a = [1 5 3];
a_sum = 0;
for it=1:length(a)
   a_sum = a_sum + a(it) ;
end
a_sum

% - To convert to physical units simply multiply all the fv.vertices
% coordinates with their corresponding voxel dimension. You can use repmat
% to create a voxel size matrix of the same dimension as fv.vertices and
% then use .* to perform elementwise multiplication.
help repmat
help .*
a = [1 4 6; 2 3 4]
b = [2 6 3]
c = a.*repmat(b,[2 1])

%% Test the interface area function

% create a sphere of radius 25 and show a slice as an image
radius = 25; % voxels
[vol_sphere, sphere_interface_area] = get_sphere(radius);
figure, imagesc(vol_sphere(:,:,27)), colormap gray

% the function also returns the theoretical interface area of the ideal
% sphere. If we set the voxel size to [1 1 1] we can use this to test our
% newly implemented function.
voxel_size = [1 1 1];

% HINTS:
vol_smooth = smooth3(vol_sphere);

%% Inteface area of the freeze cast structure
% set the correct voxel size (we know this from the x-ray scanner used to acquire the images)
voxel_size = [1.11383 1.11383 1.11383]; % [um]

%% Volume fraction and volume specific interface area as a function of volume size

% HINTS:
% - start with the small sizes and plot after each change in size. This
% will take some time to compute on larger volume sizes and you will
% probably want to interrupt it before it finishes.
% - you can interrupt the for loop early by pressing ctrl-c.
% - run this section ('%%') of code with ctrl-Enter
close all % closes all current figures

voxel_size = [1.11383 1.11383 1.11383]; % [um]

% the side lengths to loop over.
side_lengths = 10:10:300; % values from 10 to 300 with an interval of 10

% allocated space for the results
solid_fractions = zeros(1,length(side_lengths));
volume_specific_interface_areas = zeros(1,length(side_lengths));

for it=1:length(side_lengths)
   vol_use = vol(1:side_lengths(it),1:side_lengths(it),1:side_lengths(it));
   
   % solid fraction
   solid_fractions(it) = 1; % replace
   
   % volume specific interface area
   volume_specific_interface_areas(it) = 1; % replace
   
   % plotting
   figure(10), plot(side_lengths(1:it),volume_specific_interface_areas(1:it),'r-'),title('Volume specific interface areas')
   xlabel('Volume side length [voxels]')
   ylabel('A_V [?]')
   figure(11), plot(side_lengths(1:it),solid_fractions(1:it),'r-'), title('Solid volume fraction');
   xlabel('Volume side length [voxels]')
   ylabel('Solid fraction [-]')
end

















