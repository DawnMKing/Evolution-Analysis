function [] = fix_population(base_name,run_name)
global SIMOPTS;
pn = ['population_' base_name run_name];
load(pn);
G = find(population>=SIMOPTS.limit);
population = population(G);
save(pn,'population');
end