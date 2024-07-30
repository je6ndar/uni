function image_stack = load_image_stack(load_path,prename,type)

% loads a 3D image from a stack of images.
% image_stack = load_image_stack(path,prename,type)
% path: The path string where the images are located
% prename: The name of the image series prior to the serial number
% type: the image type (or last name) of the images. e.g. 'tif' or 'bmp'

dir(load_path); % just to produce a sensible error message
dir_info = dir(load_path);

number_range_start = length(prename)+1;
type_length = length(type);

n_images = 0;

image_names = [];
image_numbers = [];

% located the image files
for it_file=1:length(dir_info)
    c_file = dir_info(it_file);
    
    if c_file.isdir
       continue; 
    end
    
    [~,name,ext] = fileparts(c_file.name);
    % ignore files of other types than the specified one.
    if ~strcmp(ext,type)
        continue;
    end
    
    n_images = n_images+1;
    image_names{n_images} = c_file.name;
    image_numbers(n_images) = str2num(name(number_range_start:end));    
end

% give throw an error message if we didnt find any images of the specified type
if isempty(image_numbers)
error('No images of the specified type found at: %s',load_path)
end

% check consistency of image files for missing sequence numbers etc.
[~, image_index] = sort(image_numbers);

% create the output stack based on the amount of images found.

% load the first image to check the size
image_load_path = fullfile(load_path,image_names{1});
im = imread(image_load_path);

image_size = size(im);
n_images = length(image_numbers);
image_stack = zeros(image_size(1),image_size(2),n_images,class(im));

% load each image and copy the content into the image stack.
for it_im=1:n_images
   clc
   disp(strcat(num2str(it_im),'/',num2str(n_images)))
   image_load_path = fullfile(load_path,image_names{image_index(it_im)});
   c_im = imread(image_load_path);
   c_id_im = c_im;
   image_stack(:,:,it_im) = mean(c_id_im,3); % convert RGB images to grayscale
end

