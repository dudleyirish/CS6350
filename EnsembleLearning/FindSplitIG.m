%% usage: node = FindSplitIG (S, attr_names, attr_values)
%%
%% Use information gain as criteria to select attribute to split the tree on.
%%  
%%  S - the sample data
%%  attr_names - string labels for the attributes
%%
%%  Return value is the attribute on which to split
%%
function attr = FindSplitIG (S, Dt, attr_names, attr_values)
  global outf
  EntropyS = H(S(:,end), Dt);
  fprintf(outf, "\n    Entering FindSplit: EntropyS = %d, %d\n", ...
	  EntropyS, columns(S));
  gains = [];
  
  for attr = 1:columns(S)-1
    fprintf(outf, "    Information gain: %s\n", attr_names{attr});
    values = attr_values{attr};
    if strcmp(values{1}, 'numeric')
      values = {0, 1};
    end
    sum = 0;
    for idx = 1:columns(values)
      Sv = S(find(S(:, attr) == idx), end);
      Dtv = Dt(find(S(:, attr) == idx));
      values_str = values{idx};

      if isempty(Sv)
	fprintf(outf, "        %s = %s: 0 of %d examples\n", ...
		attr_names{attr}, values_str, rows(S));
	fprintf(outf, "            p = 0  n = 0  Hs = 0\n");
      else
	[EntropySv, ir] = H(Sv, Dtv);
	fprintf(outf, "        EntropySv = %d, ir = %d\n", ...
		EntropySv, ir);
	sum = sum + rows(Sv)/rows(S) * EntropySv;
	fprintf(outf, "        %s = %s: %d of %d examples\n", ...
		attr_names{attr}, values_str, rows(Sv), rows(S));
	fprintf(outf, "            p = %s  n = %s  Hs = %d\n", ...
		strtrim(rats(ir(1))), strtrim(rats(ir(2))), EntropySv);
      end
    end
    gains(attr) = EntropyS - sum;
    fprintf(outf, "        Information gain: %d\n", gains(attr));
  end
  [maxgain, attr] = max(gains);
end
