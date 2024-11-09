%% usage: x = X_Intercept (W, y)
%%
%%
function x = X_Intercept (w, y)
  x = -(w(2)*y+w(3))/w(1);
end
