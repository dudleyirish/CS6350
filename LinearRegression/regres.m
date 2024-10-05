%% usage: [b1 b2] = regres (S)
%%
%%
function [b1 b2] = regres (S)
  n = rows(S);
  sumx = sum(S(:,1));
  sumy = sum(S(:,2));
  sumprod = sum(S(:,1).*S(:,2));
  sumsq = sum(S(:,1).^2);
  b1 = (n*sumprod - sumx*sumy)/(n*sumsq - sumx^2);
  b2 = (sumy - b1*sumx)/n;
endfunction
