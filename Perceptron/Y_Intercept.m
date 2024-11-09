%% usage: y = Y_Intercept (w, x)
%%
%%
function y = Y_Intercept (w, x)
  y = -(w(1)*x+w(3))/w(2);
end
