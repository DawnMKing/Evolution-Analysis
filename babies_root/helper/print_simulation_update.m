%% print_simulation_update.m
% [] = print_simulation_update(gen,pop,mus,exp_name,run)
% Prints every 10 generations a population (and mutabilty) update to the command window.

function [] = print_simulation_update(gen,pop,mus,exp_name,run),  
global SIMOPTS;
if ~mod(gen,10), %Display progress every 10 generations
  if SIMOPTS.exp_type==0 || SIMOPTS.exp_type==3, %Single mutability or duel
    if ~mod(gen,100), 
      fprintf(['%1.0f gen \t %1.0f pop run %1.0f of ' exp_name '\n'],gen,pop,run);
    else, 
      fprintf(['%1.0f gen \t %1.0f pop \n'],gen,pop);
    end
  else, %Competing mutabilities
    if ~mod(gen,100), 
      fprintf(['%1.0f gen \t %1.0f pop \t %1.0f mus of ' exp_name '\n'],gen,pop,mus);
    else, 
      fprintf(['%1.0f gen \t %1.0f pop \t %1.0f mus \n'],gen,pop,mus);
    end
  end
end
end

