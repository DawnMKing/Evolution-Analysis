%% move_data.m moves or copies file to a specific location

%
%%
function [] = move_data(base_name,out_name,run_name)




% if exist(['Perc_num_clus_' base_name run_name '.mat'])==2
%   copyfile(['Perc_num_clus_' base_name run_name '.mat'],...
%       [out_name 'Data\']);
% end
if exist(['Perc_clus_size_' base_name run_name '.mat'])==2
  copyfile(['Perc_clus_size_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
if exist(['Perc_clus_size' base_name run_name '.mat'])==2
  copyfile(['Perc_clus_size' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
if exist(['population_' base_name run_name '.mat'])==2
  copyfile(['population_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
if exist(['centroid_x_' base_name run_name '.mat'])==2
  copyfile(['centroid_x_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
if exist(['centroid_y_' base_name run_name '.mat'])==2
  copyfile(['centroid_y_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
  if exist(['trace_x_' base_name run_name '.mat'])==2
  copyfile(['trace_x_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['trace_y_' base_name run_name '.mat'])==2
  copyfile(['trace_y_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['trace_cluster_seed_' base_name run_name '.mat'])==2
  copyfile(['trace_cluster_seed_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['trace_cluster_' base_name run_name '.mat'])==2
  copyfile(['trace_cluster_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['num_clusters_' base_name run_name '.mat'])==2
  copyfile(['num_clusters_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['cluster_diversity_' base_name run_name '.mat'])==2
  copyfile(['cluster_diversity_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
  if exist(['kills_' base_name run_name '.mat'])==2
  copyfile(['kills_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['orgsncluster_' base_name run_name '.mat'])==2
  copyfile(['orgsncluster_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['parents_' base_name run_name '.mat'])==2
  copyfile(['parents_' base_name run_name '.mat'],...
      [out_name 'Data\']);
  end
  if exist(['seed_distances_' base_name run_name '.mat'])==2
  copyfile(['seed_distances_' base_name run_name '.mat'],...
      [out_name 'Data\']);
end
end
