global SIMOPTS;
fit_level = landscape_heights(1);
i = 0;
if vary_death == 0%if mu is control parameter
param = mutability;
else%if death_max is control parameter
param = death_max;
end

avg_nc = zeros(length(param),length(SIMS));
min_nc = zeros(length(param),length(SIMS));
AVG_NCS = zeros(length(param),1);
STD_NCS = zeros(length(param),1);
MIN_NCS = zeros(length(param),1);
NGENS = zeros(length(param),length(SIMS));

AVG_GEN_NCS = zeros(length(param),NGEN);
STD_GEN_NCS = zeros(length(param),NGEN);

for op = overpop, SIMOPTS.op = op;
for dm = death_max, SIMOPTS.dm = dm;
for mu = mutability, SIMOPTS.mu = mu;
  make_dir = 0; [base_name,dir_name] = NameAndCD(make_dir,do_cd);
  gen_ncs = zeros(length(SIMS),NGEN);
  i = i +1;
  for run = SIMS
    run_name = int2str(run);
    nc_name = ['num_clusters_' base_name run_name]%make_data_name('num_clusters',base_name,run_name,0);
    go = 1; [nc,go] = try_catch_load(nc_name,go,1);
    if go==1, 
      num_clusters = nc.num_clusters; clear nc
      g = find(num_clusters);
      if by_generation==0
        avg_nc(i,run) = mean(num_clusters);
        min_nc(i,run) = min(num_clusters);
        NGENS(i,run) = length(num_clusters);
      elseif by_generation==1 && by_window==0
        gen_ncs(run,1:length(g)) = num_clusters(g);
      elseif by_generation==1 && by_window==1
        j = 0;  overlap = 5;  window = 10;  num_windows = ceil(ngen/overlap); k = -overlap +1;
      end
    end
  end
  if by_generation==1
    AVG_GEN_NCS(i,:) = mean(gen_ncs,1);
    STD_GEN_NCS(i,:) = std(gen_ncs);
  end
  AVG_NCS(i) = mean(avg_nc(i,:));
  STD_NCS(i) = std(avg_nc(i,:));
  MIN_NCS(i) = min(min_nc(i,:));
end
end
end

if do_num_clusters_plot==1 
  figure(4);
  tn = make_title_name(make_data_name('num_clusters',base_name,'',1),'');
  nz = find(AVG_NCS);
  errorbar(param(nz),AVG_NCS(nz),STD_NCS(nz));
  title(tn,'FontSize',16);  xlabel('\mu','FontSize',14);  ylabel('num\_clusters','FontSize',14);
  xlim([min(param) max(param)]); 
end