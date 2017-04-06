%% linear_fit.m
% [m,b,sigm,sigb] = linear_fit(x,y,sigma,do_plot)
% Plots the data x & y along with the line of best fit. The title of the
% plot reports the slope and intercept values for the line of best fit. The
% fit is derived from least squares fitting.
% Inputs:
% x - vector of horizontal variable
% y - vector of vertical variable
% sigma - error of y (can pass [] if not available)
% do_plot - option to create the figure of plotted data (figure 491)
% Outputs:
% m - slope of best fit line
% b - y-intercept of best fit line
% sigm - error in the computed slope, m
% sigb - error in the computed y-intercept, b
%
% For quick use, you can just do [m,b] = linear_fit(x,y,[],0) to get the
% slope and y-intercepts without their errors or the plot.
%
% -ADS
function [m,b,sigm,sigb] = linear_fit(x,y,sigma,do_plot)
% x = [1:1:10];
% y = rand(1)*[0.8:1:9.8];
% sigma = 0.1*rand(1,length(x));
sizex = size(x);
sizey = size(y);
sizesigma = size(sigma);
if sizesigma(1)==0, sigma = ones(size(x));  end
    
S = sum(sigma.^(-2));
sumx = sum(x.*(sigma.^-2));
sumy = sum(y.*(sigma.^-2));
sumx2 = sum(x.*x.*(sigma.^-2));
sumxy = sum(x.*y.*(sigma.^-2));

b = (sumy*sumx2 -sumx*sumxy) /(S*sumx2 -sumx*sumx);
m = (S*sumxy -sumy*sumx) /(S*sumx2 -sumx*sumx);

sigb = sqrt(sumx2 /(S*sumx2 -sumx*sumx));
sigm = sqrt(S /(S*sumx2 -sumx*sumx));

if do_plot==1, 
  figure(491 +length(x));
  plot(x,y,'bx'); hold on;
  plot(x,(x*m +b),'k'); hold off;
  legend('data','best linear fit');
  title(['best fit parameters: slope = ' num2str(m) '; intercept = ' num2str(b)]);
end
end