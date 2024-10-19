%% usage: [Dt, Et, alphat] = ConstructNewWeights (Dt, S, classifier)
%%
%%
function [Dt, Et, alphat] = ConstructNewWeights (Dt, S, classifier)
  fh = str2func(classifier);
  h = zeros(rows(Dt), 1);
  Et = 0;
  for r = 1:rows(S)
    h(r) = fh(S(r, :));
    if h(r) != S(r, end)
      Et = Et + Dt(r);
    end
  end
  %%Et = 1/2 - 1/2*sum(Dt.*S(:,end).*h);
  alphat = log((1 - Et)/Et)/2;
  Dt = Dt .* exp(-alphat .* S(:,end) .* h);
  Dt = Dt/sum(Dt);
endfunction
