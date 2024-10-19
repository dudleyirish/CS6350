%% usage: CreateFinalHypothesis (name, Alpha)
%%
%% name -- name of function to create
%% Alpha -- vector of vote values
%%
function CreateFinalHypothesis (name, prefix, Alpha)
  filename = strcat(name, ".m");
  fid = fopen(filename, "w");
  if (fid == -1)
    error("Could not open output file");
  else
    fprintf(fid, "function H = %s(a)\n", name)
    fprintf(fid, "  H = %d * %s1(a);\n", Alpha(1), prefix);
    for t=2:rows(Alpha)
      fprintf(fid, "  H = H + %d * %s%d(a);\n", Alpha(t), prefix, t);
    end
    fprintf(fid, "  H = sign(H);\n");
    fprintf(fid, "end\n");
    fclose(fid);
  end
endfunction
