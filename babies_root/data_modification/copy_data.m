function [] = move_data(base_name,dm,run_name)


    if exist(['perc_lattice_by_gen_' base_name run_name '.mat'])==2
  copyfile(['perc_lattice_by_gen_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['labeled_grid_' base_name run_name '.mat'])==2
  copyfile(['labeled_grid_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['Perc_num_clus_' base_name run_name '.mat'])==2
  copyfile(['Perc_num_clus_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['Perc_clus_size_' base_name run_name '.mat'])==2
  copyfile(['Perc_clus_size_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['Perc_clus_size' base_name run_name '.mat'])==2
  copyfile(['Perc_clus_size' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['population_' base_name run_name '.mat'])==2
  copyfile(['population_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['trace_x_' base_name run_name '.mat'])==2
  copyfile(['trace_x_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end
if exist(['trace_y_' base_name run_name '.mat'])==2
  copyfile(['trace_y_' base_name run_name '.mat'],...
      ['F:/babies_root/Assortative_Mating/Mu_x/Uniform/2_Flatscape/' dm '_indiv_death_max/Data']);
end