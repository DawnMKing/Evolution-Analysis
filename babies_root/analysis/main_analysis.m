%% main_analysis.m *******************************************************
% This function is based on the main_babies template which means setting up
% analysis for a particular simulation may be done by choosing the typical
% options. Note that at the end, there are options for gathering population
% or num_clusters data. More updates which will allow for other analysis
% options may be added there as well.


% pctconfig('portrange',[27370 27470])
%% START CLEAN & RANDOM
clear; clc; %close all;
rng('shuffle','twister');

%% PARAMETERS
% Data creation options
source = 'C:\Users\Dawn\Desktop\ForGITHUB\Evolution-Analysis\babies_root\';%Directory to source code data;
  do_cd = 1;
output = 'C:\Users\Dawn\Desktop\babies_root\';%Directory that data is located;

write_over = 0;% write over analysis already run (1), skip if already ran (0)


% What data to create--parameter values must match the simulation that was
% run.
% Simulation numbers
SIMS = [1]; %simulation identifiers used in simulation looping

% Initial parameter settings
NGEN = 20; %number of generations to run
IPOP = 300; %number of initial population
limit = 3; %minimum cluster size/extinction population +1

% Birth settings
  % Reproduction options
  distribution = 0; %offspring distrubtion: 0=uniform, 1=normal
  reproduction = 0; %assortative mating = 0, bacterial cleaving = 1, random mating = 2
  % Mutability option
  exp_type = 0; %same mutability = 0; competition = 1; duel = 2
  % Single Mutability settings
  dmu = 0.01;  mutability = [0.300];
  % Two mu competition settings
  bi = [1.31 2.31; 150 150]; %[mu1 mu2; IPOP1 IPOP2];
  % Mutability competition settings
  range = 7; % 0 to range possible mutabilities

% Death settings
  % Local options
  dop = 0.25; overpop = 0.25; %if closer than this distance, overpopulated, and baby dies
  random_walk = 0; %0 = coalescing, 1 = annihilating
  % Global options
  ddm = 0.01;  death_max = [0.01:ddm:0.04]; %percent of random babies dying varies from 0 to this value.
  indiv_death = 1;  %random percentage of entire pop dies = 0; individual probability = 1
  vary_death = 1; %if the conrol is the death max (1) if contol is mu (0)
% Landscape options
   landscape_heights = [2 2]; %min and max of landscape; for flat landscapes, only min is taken
  %If both values are the same, then a flatscape will be generated.
   % Size
  basic_map_sizes = [12]; %X and Y lengths for the basic map size
  basic_map_size = [12 12];
 %May just put in a check on whether one basic_map_size values is 1

  global SIMOPTS;
  SIMOPTS = struct('source',source,'output',output,'write_over',write_over,...
    'SIMS',SIMS,'NGEN',NGEN,'IPOP',IPOP,'limit',limit,'op',[],'dm',death_max,'indiv_death',indiv_death,...
    'basic_map_sizes',basic_map_sizes,'basic_map_size',basic_map_size,...
   'distribution',distribution,'reproduction',reproduction,'landscape_heights',landscape_heights,...
   'exp_type',exp_type,'mutability',mutability,'bi',bi,'range',range,'vary_death',vary_death)
    

total_params = length(mutability)*length(overpop)*length(death_max);
%% What to make excel file of
record_data = 1; %populations and number of clusters
record_R = 0;

%% What to analyze?
        %Data & recording                 %Visualizations                    %Options
                do_populations = 0;        do_populations_plot = 1;             by_generation = 0;
                                                   do_std_plot = 1;                
                                                   
                                            
               do_num_clusters = 0;       do_num_clusters_plot = 0;
           
             do_seed_distances = 0; %only nee to run if missing Seed_distances file from simulation to do Clark & Evans test 
           do_Clark_Evans_test = 0;        do_population_level = 1;
                                              do_cluster_level = 0;
                                                      do_R_plot = 1;                     
                                                                             
                      do_kills = 0;              do_kills_plot = 1;                 all_kills = 1;
                
                do_plot_indivs = 1;                 make_video = 0;        
                    plot_run = SIMS(1); %must be single simulation run                                                                 
                    plot_gens = 20;%if make_movie=0, provide single value generation(eg 2000)
                       %if make_movie=1,provide generation vector over generations to run movie (eg [1:200])
                    subplots = 1;
                    color_code = [1 2 3 4 5 6 7];
                                                     % plot_hc_mu = mutability;
                                                                %          plot_hc_dm = death_max;%
                                                                                  plot_hc_run = SIMS;
                                                                                plot_hc_gen = 100;
     export_coords=0;
%% The Analysis
tic

  if do_populations, get_populations;  end %updated 11/1/12

  if do_num_clusters, get_num_clusters;  end %updated 11/1/12

  if record_data,
    if do_populations, write_populations;  end
    if do_num_clusters, write_clusters; end
    if do_populations && do_num_clusters, write_lifetimes; end
  end   %updated 11/1/12

 if do_seed_distances, make_seed_distances;  end
  
  if do_Clark_Evans_test,  get_R; end
    if record_R, write_R;  end
 
  
 
  if do_plot_indivs, plot_indivs;  end
  
  if do_kills, get_kills;  end

toc
