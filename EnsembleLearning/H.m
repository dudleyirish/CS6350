##
## Compute entropy of an array of values.
##
function [h, ir] = H(A, Dt)
  if isempty(A)
    h = 0; ir = [0];
  else
    tot = sum(Dt);
    ir = [0, 0];
    u = unique(A);
    N = rows(u);
    s = 0;
    for k = 1:N
      p = sum(Dt(A == u(k)));
      s = s + -p*log2(p);
      ir(k) = p;
    end
    h = s;
  end
end
