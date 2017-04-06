%plot_indivs.m
% This function allows you to specify a string identifying a simulation set, a string
% telling which specific simulation, and for what generation you'd like to see where
% organisms are in the phenospace.
% Inputs:
% base_name = string identifying a simulation set
% run_name = string identifying the particular simulation number
% gen = generation of organisms to plot
% function [] = plot_indivs(base_name,run_name,gen)
% function [] = plot_indivs(base_name,run_name,gen,color_code)
global SIMOPTS;
m = 0;  cc = color_code;
for op = overpop, SIMOPTS.op = op;
for dm = death_max, SIMOPTS.dm = dm;
for mu = mutability, SIMOPTS.mu = mu;

 if vary_death == 1
 par = dm;                plot_param = death_max;  
          %          param = death_max;
                    else
 par= mu;                  plot_param = mutability;%
         %           param = mutability;
                    end 
  make_dir = 0; [base_name,dir_name] = NameAndCD(make_dir);
   m = m +1;
  if par==plot_param(m)
    for run = SIMS
      run_name = int2str(run);
      exp_name = [base_name run_name];
      color_code = cc; 
        if run==plot_run
          if limit~=3
            fign = ceil(1000*par)+limit;
          else
            fign = ceil(1000*par);
          end
          figure(fign);
          set(figure(fign),'WindowStyle','normal','Position',[1 45 450 450]);
          h = 0;
          pn = ['population_' exp_name];  load(pn);
          if subplots==0 && make_video==1
            plot_gens = 1:NGEN;
          end
          txn = ['trace_x_' exp_name];  load(txn);
          tyn = ['trace_y_' exp_name];  load(tyn);
          if limit~=3
            tcn = ['trace_cluster_' base_name int2str(limit) '_limit_' run_name]; load(tcn);
          else
            tcn = ['trace_cluster_' exp_name]; load(tcn);
          end
          for generation = plot_gens
            if export_coords==1

            else
              if subplots==1
                h = h +1; subplot(2,2,h);
              end

              u = sum(population(1:generation-1)) +1;  v = sum(population(1:generation));
              t = [];
              for cci = 1:length(color_code)
                t = [t find(trace_cluster(u:v)~=color_code(cci))'];
              end
              t = unique(t)' +u -1;
              plot(trace_x(t)-0.5,trace_y(t)-0.5,'.g','MarkerSize',4);  hold on;
              xywh = get(gca,'Position');
              set(gca,'Color','k','PlotBoxAspectRatioMode','manual')
              if h==1
                set(gca,'Position',[0.010 0.510 0.45 0.45]);
              elseif h==2
                set(gca,'Position',[0.510 0.510 0.45 0.45]);
              elseif h==3
                set(gca,'Position',[0.010 0.010 0.45 0.45]);
              elseif h==4
                set(gca,'Position',[0.510 0.010 0.45 0.45]);
              end
              colors = ['oworobdwdrdb'];
%               plot(trace_x(u:v)-0.5,trace_y(u:v)-0.5,'g.','MarkerSize',4);  hold on;
%               set(gca,'Color','w');
%               colors = ['oroboksrsbsk'];
              if max(trace_cluster(u:v))<max(color_code)
                if length(color_code)>1
                  if max(trace_cluster(u:v))>1
                    l = 0;
                    for k = 1:(color_code(2)-color_code(1)):color_code(max(trace_cluster(u:v)))
                      l = l +1;
                      color_code(l) = k;
                    end
                  else
                    cc = color_code;
                    color_code = 1;
                  end
                end
              end
              if length(color_code)>6
                color_code(7:length(color_code)) = [];
              end
              if color_code(1)>0
                j = 0;
                for i=color_code
                  j = j +2;
                  ci = find(trace_cluster(u:v)==i);
                  plot(trace_x(u-1+ci)-0.5,trace_y(u-1+ci)-0.5,colors(j-1:j),'MarkerSize',3,'MarkerFaceColor',colors(j));
                end
              end
              hold off;
              land_size = ((((basic_map_size*2)-1)*2)-1);
              xlim([0 land_size(1)]); ylim([0 land_size(2)]);
              [tn] = make_title_name(base_name,run_name);
            end

            title([make_title_name(base_name,run_name) ' @ generation ' int2str(generation)]);
        %   tick mark only on bottom left subplot figure
            if plot_param(m)==1.25 && i==1
              set(gca,'XTick',[0:floor(land_size(1)/3):land_size(1)],'XTickLabel',{},...
                'YTick',[0:floor(land_size(2)/3):land_size(2)],'YTickLabel',{});
            else
              set(gca,'XTick',[0 land_size(1)],'XTickLabel',{},...
                'YTick',[0 land_size(2)],'YTickLabel',{});
            end
            if make_video==1, indiv_movie(generation) = getframe; end
          end
        end
    end
    if make_video==1, movie2avi(indiv_movie,[base_name int2str(plot_run)],'compression','none'); end
  end
end%mu
end%dm
end%op