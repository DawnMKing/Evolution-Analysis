global SIMOPTS;

AVG_GEN_NN_DIST = zeros(NGEN,length(mutability)*length(death_max)*length(overpop));
STD_GEN_NN_DIST = zeros(NGEN,length(mutability)*length(death_max)*length(overpop));
avg_nn_dist = zeros(length(mutability)*length(death_max)*length(overpop),length(SIMS));
AVG_NN_DIST = zeros(length(mutability)*length(death_max)*length(overpop),1);
STD_NN_DIST = zeros(length(mutability)*length(death_max)*length(overpop),1);
i = 1;
avgR = zeros(length(mutability)*length(death_max)*length(overpop),length(SIMS));
avgc = zeros(length(mutability)*length(death_max)*length(overpop),length(SIMS));
AVG_R = zeros(length(mutability)*length(death_max)*length(overpop),1);
STD_R = zeros(length(mutability)*length(death_max)*length(overpop),1);
AVG_c = zeros(length(mutability)*length(death_max)*length(overpop),1);
STD_c = zeros(length(mutability)*length(death_max)*length(overpop),1);
GEN_R = zeros(NGEN,length(mutability)*length(death_max)*length(overpop));
GEN_c = zeros(NGEN,length(mutability)*length(death_max)*length(overpop));

b = 0;
for op = overpop, SIMOPTS.op = op;
for dm = death_max, SIMOPTS.dm = dm;
for mu = mutability, SIMOPTS.mu = mu;
  make_dir = 0;do_cd = 1; [base_name,dir_name] = NameAndCD(make_dir,do_cd);
  b = b +1;  
  m_nn_dist = zeros(NGEN,length(SIMS));
  r = 0;
  for run = SIMS, 
    r = r +1;
    run_name = int2str(run);
    exp_name = [base_name run_name];
    go = 1; long = 0;
    %need population, trace_cluster_seed, and seed_distances as minimum requirements
    [p,go] = try_catch_load(make_data_name('population',...
      base_name,run_name,0),go,1);
    if go==1, population = p.population;  clear p, end
    if go==1, 
      [tcs,go] = try_catch_load(make_data_name('trace_cluster_seed',...
       base_name,run_name,0),go,1);
      if go==1, trace_cluster_seed = tcs.trace_cluster_seed; clear tcs,  end
    end
    if go==1,
      [sd,go] = try_catch_load(make_data_name('seed_distances',...
        base_name,run_name,0),go,1);
      if go==1, seed_distances = sd.seed_distances; clear sd, end
    end
    if go==1, 
      working_on = exp_name
      load(['trace_x_' exp_name]);
      load(['trace_y_' exp_name]);
      
      ngen = length(population);

      lsx = (((basic_map_size(2)*2) -1)*2) -1;
      lsy = (((basic_map_size(1)*2) -1)*2) -1;
      u = 0;  v = 0;
      for gen = 1:ngen %for each generation of this run
        u = v +1;
        v = sum(population(1:gen));
        refs = u:v; %the reference organisms of this generation
        m_nn_dist(gen,r) = mean(seed_distances(refs,1));  %average nearest neighbor distances
      end %for gen
      this_m_nn_dist = m_nn_dist(find(m_nn_dist(:,r)),r); %m_nn_dist of this simulation
      avg_nn_dist(b,r) = mean(this_m_nn_dist); %average of averages nn_dists
      %%
      area = lsx*lsy; %area of the landscape
      rho = population'./area;  %density for each generation
      mrd = 0.5*(rho.^-0.5);  %denominator of R (expected density if random population)
      R = this_m_nn_dist./mrd;  %R for each generation
      sigma_mrd = 0.26136./sqrt(population'.*rho);  %variance of R for each generation
      c = (this_m_nn_dist -mrd)./sigma_mrd; %confidence in R for each generation
      avgR(b,run) = mean(R);  %time averaged R
      avgc(b,run) = mean(c);  %time averaged c
      GEN_R(1:length(R),b) = R; %store R for each generation for this simulation run
      GEN_c(1:length(c),b) = c; %store c for each generation for this simulation run

      %%
    end
  end
  AVG_R(b) = mean(avgR(b,:)); %simulations averaged of time averaged R
  STD_R(b) = std(avgR(b,:));  %simulations standard deviation of time averaged R
  AVG_c(b) = mean(avgc(b,:)); %simulations averaged of time averaged c
  STD_c(b) = std(avgc(b,:));  %simulations standard deviation of time averaged c
  %%
 
end
end
end
AVG_NN_DIST = mean(avg_nn_dist,2);
STD_NN_DIST = std(avg_nn_dist')';

%%
if vary_death == 0%if mu is control parameter
param = mutability;
else%if death_max is control parameter
param = death_max;
end
%%
if do_R_plot==1
    
  figure(6);
  errorbar(param,AVG_R,STD_R,'x');
  title(make_title_name(make_data_name('',base_name,'',1),''));
  xlabel('\delta');  ylabel('R');
  
  figure(7);
  errorbar(param,AVG_c,STD_c,'x');
  title(make_title_name(make_data_name('',base_name,'',1),''));
  xlabel('\mu');  ylabel('R significance for two-tailed test');
  hold on;
  plot([min(param) max(param)],[1.96 1.96],'k');
  plot([min(param) max(param)],[2.58 2.58],'b');
  plot([min(param) max(param)],[-1.96 -1.96],'k');
  plot([min(param) max(param)],[-2.58 -2.58],'b');
end
