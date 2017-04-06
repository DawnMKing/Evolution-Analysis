%% NameAndCD.m
% According to input options and settings, the experiment name is generated.
% Inputs - make_dir
% Output - exp_name, dir_name
% make_dir, if set to 1 will make a new directory if the directory indicated by dir_name
% does not exist. If set to 0, then if the directory indicated by dir_name does not exist, 
% the directory will not be created, and an error will be thrown to the command window. If 
% an error is thrown, then whatever is running will continue.
% exp_name is the base name for simulation ordered as: mating scheme _ single mu/competition _
% offspring distribution _ landscape movement/fitness level _ landscape type _ initial
% population size _ mutability range _ two mu competitors (mu1 population size _ mu1 _ v _
% mu2 population size _ mu2)
% dir_name is the corresponding directory name to exp_name
% Note: if a particular option or setting isn't displayed in the file base name, then it
% is most likely that you have chosen the default setting, OR much less likely, the
% handling is not considered in the source code within this function. You will then have
% to update this function.
%
% How to customize/use NameAndCD:
% You must organize your data according to an organizational
% tree of subfolders which specify the simulation options in the folder
% names. All data is then listed under it's specified simulation options
% path name in a folder labeled Data. This organization should help those
% on at least Windows computers with opening data folders quicker while in
% Windows Explorer as well (too much data file storage in one folder can
% slow loading of data folders, so this helps minimize exploring folders
% along with keeping the data nice and tidy). For help organizing your
% folder tree, see NameAndCD.m for the dir_name variable which tells Matlab
% where your data should be. Subsequently, the source parameter in
% main_babies_#.m should contain everything up to the folder where dir_name
% begins to accumulate directories. For example, I have my data tree
% starting at
% 'C:\Users\amviot\Research\Programming\Babies\generalized_Expt\' on my
% laptop. You may add hard code within NameAndCD.m such that you can assign
% a number like 0, 1, 2, etc. to different starting data trees for your
% data. See NameAndCD.m for how I have done this for a couple of source
% locations on my lab desktop and lab external HDD.
% function [exp_name,dir_name] = NameAndCD(exp_type,bnoise,bi,rndm,landscape_movement,...
%   NGEN,landscape_heights,shock,IPOP,range,rep,loaded,load_name,death_max,indiv_death,...
%   basic_map_size,linear,source,limit,make_dir,random_walk,overpop)
function [exp_name,dir_name,output_name] = NameAndCD(make_dir,do_cd)
global SIMOPTS;
if ~exist('do_cd','var'),  do_cd = 1; end
exp_name = [];  dir_name = []; output_name = [];old_name =[];

if SIMOPTS.reproduction==0, 
  exp_name = [exp_name]; dir_name = [dir_name 'Assortative_Mating\'];
elseif SIMOPTS.reproduction==1, 
  exp_name = 'Bacterial_'; dir_name = [dir_name 'Bacterial\'];
elseif SIMOPTS.reproduction==2, 
  exp_name = 'Random_Mating_'; dir_name = [dir_name 'Random_Mating\']; 
end

n2sb = proper_name(SIMOPTS.mutability);
if SIMOPTS.exp_type==0, 
  exp_name = [exp_name 'Mu' n2sb '_'];  dir_name = [dir_name 'Mu_x\'];
elseif SIMOPTS.exp_type==1, 
  exp_name = [exp_name 'Comp_']; dir_name = [dir_name 'Comp\']; 
elseif SIMOPTS.exp_type==3, 
  exp_name = 'Confined_';  dir_name = [dir_name 'Confined\'];  
end

if SIMOPTS.distribution==0, 
  exp_name = [exp_name 'Uniform_']; dir_name = [dir_name 'Uniform\'];
else, 
  exp_name = [exp_name 'Normal_']; dir_name = [dir_name 'Normal\'];  
end


if SIMOPTS.landscape_heights(1)~=SIMOPTS.landscape_heights(2), 
    if SIMOPTS.shock==0, 
      exp_name = [exp_name 'Shifting_']; dir_name = [dir_name 'Shifting\'];
    elseif SIMOPTS.shock==1 || SIMOPTS.landscape_movement~=2, 
        exp_name = [exp_name int2str(SIMOPTS.landscape_movement) '_Shock_'];
        dir_name = [dir_name int2str(SIMOPTS.landscape_movement) '_Shock\'];
    end
elseif SIMOPTS.landscape_heights(1)==SIMOPTS.landscape_heights(2), 
  exp_name = [exp_name int2str(SIMOPTS.landscape_heights(1)) '_Flatscape_']; 
  dir_name = [dir_name int2str(SIMOPTS.landscape_heights(1)) '_Flatscape\']; 
end

if SIMOPTS.basic_map_size(1)~=12 || SIMOPTS.basic_map_size(2)~=12, 
  exp_name = [exp_name int2str(SIMOPTS.basic_map_size(1)) 'x' ...
    int2str(SIMOPTS.basic_map_size(2)) '_basic_map_size_'];
  dir_name = [dir_name int2str(SIMOPTS.basic_map_size(1)) 'x' ...
    int2str(SIMOPTS.basic_map_size(2)) '_basic_map_size\'];
end

if SIMOPTS.IPOP~=300,
  exp_name = [exp_name int2str(SIMOPTS.IPOP) '_IPOP_']; 
  dir_name = [dir_name int2str(SIMOPTS.IPOP) '_IPOP\'];
end

if SIMOPTS.exp_type==2, 
  exp_name = [exp_name int2str(SIMOPTS.bi(2,1)) '_' int2str(SIMOPTS.bi(1,1)*100)...
    '_v_' int2str(SIMOPTS.bi(2,2)) '_' int2str(SIMOPTS.bi(1,2)*100) '_'];
  dir_name = [dir_name int2str(SIMOPTS.bi(2,1)) '_' int2str(SIMOPTS.bi(1,1)*100)...
    '_v_' int2str(SIMOPTS.bi(2,2)) '_' int2str(SIMOPTS.bi(1,2)*100) '\'];
end

if SIMOPTS.dm~=0.7, 
  n2sdm = proper_name(SIMOPTS.dm);
  if SIMOPTS.indiv_death==0, 
    exp_name = [exp_name n2sdm '_death_max_'];
    dir_name = [dir_name n2sdm '_death_max\'];
  elseif SIMOPTS.indiv_death==1, 
    exp_name = [exp_name n2sdm '_indiv_death_max_'];
    dir_name = [dir_name n2sdm '_indiv_death_max\'];
  end
end

if SIMOPTS.op~=0.25, 
  n2sop = proper_name(SIMOPTS.op);
  exp_name = [exp_name n2sop '_overpop_'];
  dir_name = [dir_name n2sop '_overpop\'];
end

if SIMOPTS.NGEN~=2000, 
  exp_name = [exp_name int2str(SIMOPTS.NGEN) '_NGEN_'];
  dir_name = [dir_name int2str(SIMOPTS.NGEN) '_NGEN\'];
end

output_name = [SIMOPTS.output dir_name];


if do_cd,
try 
  cd([output_name 'Data\']);
catch
    
  if make_dir==1
    mkdir([output_name 'Data\']);
         
    cd([output_name 'Data\']);
  else
    error = [output_name 'directory does not exist']
  end%make_dir
end%try
end%do_cd
end