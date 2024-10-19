%% usage: Et = ComputeWeightedError (Dt, S, classifier)
%%
%%
function Et = ComputeWeightedError (Dt, S, classifier)
  fh = str2func(classifier);
  h = zeros(rows(Dt), 1);
  for r = 1:rows(S)
    h(r) = fh(S(r, :));
  end
  Et = 1/2 - 1/2*sum(Dt.*S(:,end).*h);
endfunction
