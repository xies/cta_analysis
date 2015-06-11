%LOAD_EDGE_SCRIPT
%
% Pipeline for loading data from the MATLAB/EDGE-1.06 folder into various file
% structures, including stand-alone arrays (e.g. areas, myosins), as well
% as an array of embryo_structure containing the measurements as fields.
%
% If multiple embryos are loaded, will use the input.tref frame as a
% reference and generate aligned arrays for all data fields (including
% those in embryo_structure)
%
% Important outputs: embryo_stack - 1xN structure containing all loaded
%                      EDGE measurements for N embryos
%
%                    cells - cell-centric structure
%
%                    areas, myosins, etc - T_tot x N_cell num arrays (or
%                      cell-arrays for things like vertices) of the given
%                      data loaded from all embryos
%
%                    input - 1xN structure containing input file/image info
%
%                    num_cells - 1xN array of number of cells loaded from
%                      each embryo
% Feb 2013
% xies@mit.edu

%% Input the filenames and image information

clear input*;

input(1).folder2load = '~/Documents/MATLAB/EDGE-1.06/DATA_GUI/char RNAi 05-22-2015-5/Measurements';
input(1).zslice = 1;
input(1).actual_z = 7;
input(1).tref = 15;
input(1).t0 = 0;
input(1).dt = 7.5;
input(1).um_per_px = 0.213;
input(1).X = 1000;
input(1).Y = 400;
input(1).T = 60;
input(1).yref = 32; %um
input(1).embryoID = 1;
input(1).last_segmented = 50;
input(1).fixed = 0;
input(1).ignore_list = [];

input(2).folder2load = '~/Documents/MATLAB/EDGE-1.06/DATA_GUI/char RNAi 05-22-2015-4/Measurements';
input(2).zslice = 1;
input(2).actual_z = 6;
input(2).tref = 33;
input(2).t0 = 0;
input(2).dt = 8.23;
input(2).um_per_px = 0.21255;
input(2).X = 1000;
input(2).Y = 400;
input(2).T = 60;
input(2).yref = 32; %um
input(2).embryoID = 2;
input(2).last_segmented = 50;
input(2).fixed = 0;
input(2).ignore_list = [];

msmts2make = {'Membranes--basic_2d--area', ...
    'Membranes--basic_2d--Centroid-x', ...
    'Membranes--basic_2d--Centroid-y', ...
    'Membranes--vertices--Vertex-x',...
    'Membranes--vertices--Vertex-y',...
    'Myosin--myosin_intensity--Myosin intensity'...
    };

%% Load data (will beep when done)

EDGEstack = load_edge_data({input.folder2load},msmts2make{:});
beep;

%% Select which stack to load (esp. if there are multiple types of embryos)

in = input;
stack2load = EDGEstack;

%% Load into various stand-alone files (e.g. areas, myosins)

%% membrane

num_embryos = numel(in);

[areas,IDs,dev_time] = extract_msmt_data(stack2load,'area','on',in);
num_frames = size(areas,1);

areas_sm = smooth2a(areas,1,0);

areas_rate = -central_diff_multi(areas_sm,dev_time([IDs.which],:));

num_cells = zeros(1,num_embryos);
for i = 1:num_embryos
    foo = [IDs.which];
    num_cells(i) = numel(foo(foo==i));
end

%% myosin

myosins = extract_msmt_data(stack2load,'myosin intensity','on',in);
myosins_sm = smooth2a(squeeze(myosins),2,0);
% myosins_fuzzy_sm = smooth2a(squeeze(myosins_fuzzy),1,0);
myosins_rate = central_diff_multi(myosins_sm,dev_time([IDs.which],:));
% myosins_rate_fuzzy = central_diff_multi(myosins_fuzzy_sm,1:num_frames);
% coronal_myosins_sm = smooth2a(coronal_myosins,1,0);
% coronal_myosins_rate = central_diff_multi(coronal_myosins_sm);

%% Load into embryo-centric structure: embryo_stack, cells

embryo_stack = edge2embryo(stack2load,in,num_cells);
% Put extra data into embryo_stack
for i = 1:num_embryos
    embryo_stack(i).myosin_intensity = myosins(:,[IDs.which] == i);
    embryo_stack(i).area_sm = areas_sm(:,[IDs.which] == i);
    embryo_stack(i).myosin_sm = myosins_sm(:,[IDs.which] == i);
end
cells_raw = embryo2cell(embryo_stack);
