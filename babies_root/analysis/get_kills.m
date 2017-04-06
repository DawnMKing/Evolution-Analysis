global SIMOPTS;
%% get_kills
avg_kills = zeros(length(mutability),3,length(SIMS));
AVG_KILLS = zeros(length(mutability),3);
STD_KILLS = zeros(length(mutability),3);
avg_riv = zeros(length(mutability),length(SIMS));
AVG_RIV = zeros(length(mutability),3);
STD_RIV = zeros(length(mutability),3);
std_op = zeros(length(mutability),length(SIMS));
std_rd = zeros(length(mutability),length(SIMS));
std_cj = zeros(length(mutability),length(SIMS));

b = 0;
for op = overpop, SIMOPTS.op = op;
for dm = death_max, SIMOPTS.dm = dm;
for mu = mutability, SIMOPTS.mu = mu;
  make_dir = 0; [base_name,dir_name] = NameAndCD(make_dir);
  b = b +1;
  r = 0;
  for run = SIMS, 
    r = r +1;
    run_name = int2str(run);
    exp_name = [base_name run_name];
    go = 1; [p,go] = try_catch_load(['population_' exp_name],go,1);
  if go==1, [k,go] = try_catch_load(['kills_' exp_name],go,1);
  if go==1, [r,go] = try_catch_load(['rivalries_' exp_name],go,1);
  if go==1, 
    population = p.population;  clear p      
    kills = k.kills;  clear k
    avg_kills(b,:,r) = mean(kills,1);
    rivalries = r.rivalries;  clear r
    avg_riv(b,r) = mean(rivalries,1);
  end
  end
  end
  end
end
end
end
AVG_KILLS = mean(avg_kills,3);
std_op(:,SIMS) = avg_kills(:,1,:);  std_op = std(std_op')';
std_rd(:,SIMS) = avg_kills(:,2,:);  std_rd = std(std_rd')';
std_cj(:,SIMS) = avg_kills(:,3,:);  std_cj = std(std_cj')';
STD_KILLS = [std_op std_rd std_cj]; clear std_op std_rd std_cj;
AVG_RIV = mean(avg_riv,2);
STD_RIV = std(avg_riv')';
if do_kills_plot==1
  figure(666); 
  errorbar(mutability,AVG_KILLS(:,1),STD_KILLS(:,1),'x'); hold on;
  if all_kills==1, 
    errorbar(mutability,AVG_KILLS(:,2),STD_KILLS(:,2),'d');
    errorbar(mutability,AVG_KILLS(:,3),STD_KILLS(:,3),'s');
  end
  errorbar(mutability,AVG_RIV,STD_RIV,'*');
  xlabel('\mu');  ylabel('kills');  
  if all_kills==1, 
    legend('Total Competition','Random','Wanderers','Sibling Rivalry');
  else, 
    legend('Total Competition','Sibling Rivalry');
  end
  title(['average kills for ' ...
    make_title_name(generalize_base_name(base_name),'')]);
end