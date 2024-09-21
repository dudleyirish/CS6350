%% usage: cstr = cellmode (C)
%%
%%
function cstr = cellmode (C)
  u = unique(C);
  if length(u) == 0
    cstr = '';
  else
    for i = 1:length(u)
      counts(i) = length(find(strcmp(C,u(i))));
    end
    [m, mi] = max(counts);
    cstr = u(mi);
  end
endfunction
