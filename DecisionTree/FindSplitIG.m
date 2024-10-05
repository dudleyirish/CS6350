%% usage: node = FindSplitIG (S, attr_names, attr_values)
%%
%%  
%%  S - the sample data
%%  attr_names - string labels for the attributes
%%
%%  Return value is the attribute on which to split
%%
function attr = FindSplitIG (S, attr_names, attr_values)
  EntropyS = H(S(:,end));
  %%printf("\n    Entering FindSplit: EntropyS = %d, %d\n", EntropyS, columns(S));
  gains = [];
  
  for attr = 1:columns(S)-1
    %%printf("    Information gain: %s\n", attr_names{attr});
    values = attr_values{attr};
    sum = 0;
    for idx = 1:columns(values)
      if (strcmp(values(idx), 'numeric'))
	Sv = S(find(cell2mat(S(:, attr))), end);
      else
	Sv =    S(find(strcmp(S(:, attr), values(idx))), end);
      end

      if isempty(Sv)
	%%printf("        %s = %s: 0 of %d examples\n", ...
	%%       attr_names{attr}, values{idx}, rows(S));
	%%printf("            p = 0  n = 0  Hs = 0\n");
      else
	[EntropySv, ir] = H(Sv);
	sum = sum + rows(Sv)/rows(S) * EntropySv;
	%%printf("        %s = %s: %d of %d examples\n", ...
	%%       attr_names{attr}, values{idx}, rows(Sv), rows(S));
	%%printf("            p = %s  n = %s  Hs = %d\n", ...
	%%       strtrim(rats(ir(1))), strtrim(rats(ir(2))), EntropySv);
      end
    end
    gains(attr) = EntropyS - sum;
    %%printf("        Information gain: %d\n", gains(attr));
  end
  [maxgain, attr] = max(gains);
end
