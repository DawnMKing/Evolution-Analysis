%% get_popuations.m *******************************************************
global SIMOPTS;
c = 'ybrkybrk'; c = [c c c c c];
i = 1;
if vary_death == 0%if mu is control parameter
param = mutability;
else%if death_max is control parameter
param = death_max;
end
%initialize vectors
lmlS = zeros(length(param),length(SIMS));
lmN = zeros(length(param),NGEN);

avg_pop = lmlS; min_pop = lmlS; max_pop = lmlS; rat = lmlS; srat = lmlS;
ngens = lmlS; avg_end = lmlS;

lm = lmlS(:,1); AVG_POPS = lm; STD_POPS = lm; MIN_POPS = lm; MAX_POPS = lm;
RAT = lm; SRAT = lm; AVG_NGENS = lm; STD_NGENS = lm; AVG_END = lm; STD_END = lm;

AVG_GEN_POPS = lmN; STD_GEN_POPS = lmN;

tic;
for op = overpop, SIMOPTS.op = op;
for dm = death_max, SIMOPTS.dm = dm;
for mu = mutability, SIMOPTS.mu = mu;
    %build the filenames names for which you have chosen
  make_dir = 1; [base_name,dir_name,output_name] = NameAndCD(make_dir,do_cd);
  
  gen_pops = zeros(length(SIMS),NGEN);
  if vary_death == 0
  i = find(mu==param);
  else
  i = find(dm==param);
  end
 for run = SIMS
    run_name = int2str(run);
    exp_name = [base_name run_name];
    pop_name = ['population_' exp_name];
    go = 1; [p,go] = try_catch_load(pop_name,go,1);
    if go==1
      population = p.population;  clear p
      this_NGEN = length(find(population));
      g = find(population>=limit);
      if ~by_generation,  
        avg_pop(i,run) = mean(population(g));
        min_pop(i,run) = min(population(g));
        max_pop(i,run) = max(population(g));
        ngens(i,run) = g(length(g));
        rat(i,run) = mean(population(2:this_NGEN)./population(1:(this_NGEN-1)));
        if max(g)<NGEN, 
          if NGEN-END<max(g),  avg_end(i,run) = mean(population(END:max(g)));
          else, avg_end(i,run) = 0; end
        end
      else
        gen_pops(run,1:length(g)) = population(g);
       end%~by gen
    end%If go
  end%SIMS
    
  AVG_POPS(i) = mean(avg_pop(i,:));
  STD_POPS(i) = std(avg_pop(i,:));
  
  MIN_POPS(i) = min(min_pop(i,:));
  MAX_POPS(i) = max(max_pop(i,:));
  
  AVG_NGENS(i) = mean(ngens(i,:));
  STD_NGENS(i) = std(ngens(i,:));
   
  AVG_GEN_POPS(i,:) = mean(gen_pops,1);
  STD_GEN_POPS(i,:) = std(gen_pops);
end
end
end
toc;

%% Plot populations by control parameter
if do_populations_plot && by_generation==0,
      
 
  errorbar(param,AVG_POPS,STD_POPS,'*');  
  xlabel('\delta','FontSize',14);  ylabel('population','FontSize',14);
  if length(param)>1,  xlim([min(param) max(param)]); end
  figure(1);  
  if do_std_plot, figure(2); plot(param, STD_POPS);   end
 
end
%% Plot populations by generation
if do_populations_plot==1 && by_generation==1, 
  figure(3);
  tn = make_title_name(generalize_base_name(base_name),'');
  plot([1:NGEN],AVG_GEN_POPS);  title(tn,'FontSize',16);  
  xlabel('generation','FontSize',14); ylabel('<population>','FontSize',14);
  xlim([1 NGEN]); 
end


cd(SIMOPTS.source)
