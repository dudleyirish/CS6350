%% usage: e = ErrorCount (w, X, Y)
%%
%%
function e = ErrorCount (w, X, Y)
  e = 0;
  for i=1:rows(Y)
    if sign(w*X(i,:)') != Y(i)
      e = e + 1;
    end
  end
endfunction
