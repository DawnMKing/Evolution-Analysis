%% modify_data.m *******************************************************
% This may be used to modify various data. The template is that of main_babies.m and
% main_clusters.m, so you can look to those help comments for setting up your
% modifications.

%% START CLEAN
clear; clc; %close all;

%% PARAMETERS
source = 'S:\babies_root\';%'C:\Users\amviot\Desktop\Babies_Root\';%'C:\Babies_Root\'; %0 = Adam's lab computer; 1 = Adam's lab external HD
 output = 'R:\babies_root\';

% Simulation numbers
SIMS = [1:5]; %simulation identifiers used in simulation looping

% General settings
NGEN = 2000; %number of generations to run
IPOP = 300; %number of initial population
overpop = 0.25; %if closer than this distance, overpopulated, and baby dies
random_walk = 0; %coalescing = 0, annihilating = 1
ddm = 0.01;    death_max = [0.01:0.01:0.50]; %percent of random babies dying varies from 0 to this value.
indiv_death = 1; %population 0, individual = 1
limit = 3;
loaded = 0;
load_name = [''];

% Landscape options
shock = 0; %Set this to 1 to generate a new random map every landscape_movement generations

  % Landscape settings
  landscape_movement = 2*NGEN; %land moves every "landscape_movement" generations
    %There is only a default shift of 1 basic_map row, we could add this in if 
    %we really want to, but it may be unnecessary.
  landscape_heights = [2 2]; %min and max of landscape; for flat landscapes, only min is taken
  basic_map_size = [12 12]; %X and Y lengths for the basic map size
  linear = 0;
  
% Reproduction options
distribution = 0; %offspring distrubtion: 0=uniform, 1=normal
reproduction = 1; %assortative mating = 0, bacterial cleaving = 1, random mating = 2

% Mutability options
exp_type = 0; %same mutability = 0; competition = 1; duel = 2

  % Single Mutability settings
  dmu = 0.1;  mutability = [0.90];
  
  % Two mu competition settings
  bi = [1.31 2.31; 150 150];

  % Mutability competition settings
  range = 7; % 0 to range possible mutabilities
  fix_name  = 0;
  move_file = 1;
  copy_file = 0;

global SIMOPTS;
tic;
for op = overpop
for dm = death_max
    bad_dm = int2str(dm*100);
for mu = mutability
  bad_bn = int2str(mu*100);
  %% This has to be exact and set by you! The underscore at the end is necessary, so don't forget it!
  bad_name = ['Mu_' bad_bn '_Uniform_2_Flatscape_' bad_dm '_indiv_death_max_'];
  
  % Bundle simulation options into SIMOPTS
  SIMOPTS = struct('source',source,'output', output,'SIMS',SIMS,'NGEN',NGEN,'IPOP',IPOP,'limit',limit,...
    'loaded',loaded,'load_name',load_name,'op',op,'random_walk',random_walk,'dm',dm,...
    'indiv_death',indiv_death,'shock',shock,'landscape_movement',landscape_movement,...
    'landscape_heights',landscape_heights,'basic_map_size',basic_map_size,'linear',linear,...
    'distribution',distribution,'reproduction',reproduction,'exp_type',exp_type,'mu',mu,...
    'bi',bi,'range',range);
  %build the simulation names for which you have chosen to generate cluster data
  make_dir = 1; [base_name,dir_name,out_name] = NameAndCD(make_dir);
 
      
  for run = SIMS
    run_name = int2str(run);
    g = proper_name(dm)
    fprintf([base_name run_name '\n']);
    %% Include any data modification functions here
    if fix_name == 1,  movefile_data_set(bad_name,base_name,run_name); end
    if move_file == 1, move_data(base_name,out_name,run_name); end
    if copy_file == 1, copy_data(base_name,g,run_name); end
%     fix_population(base_name,run_name,limit);
%     new_name = 'a'; %test/debug name
%     if exist(['nn_dist_' bad_name run_name '.mat'])==2
%       load(['nn_dist_' bad_name run_name]);  
%       nn_dist = sqrt(nn_dist); 
%       save(['nn_dist_' base_name run_name '.mat'],'nn_dist');
%     end
%     if exist(['mnd_' bad_name run_name '.mat'])==2
%       load(['mnd_' bad_name run_name]);  
%       mnd = sqrt(mnd); 
%       save(['mnd_' base_name run_name '.mat'],'mnd');
%     end
%     if exist(['trace_cluster_seed_' bad_name run_name '.mat'])==2
%       movefile(['trace_cluster_seed_' bad_name run_name '.mat'],['trace_cluster_seed_' base_name run_name '.mat']);
%     end
%     delete_data_set(bad_name,run_name);
%     rename_data_set(bad_name,base_name,run_name);
% Uncommenting delete_data_set will get rid of the "badly named" file set, leaving your fresh, new data set alone.
%     delete_data_set(bad_name,run_name);
  end
end
end
end
toc;