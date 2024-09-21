%% usage: p2b_WriteTable (e)
%%
%%
function p2b_WriteTable (e)
  fid = fopen("p2b_error.tex", "w");
  fprintf(fid, "\\begin{table}[h]\n");
  fprintf(fid, "  \\centering\n");
  fprintf(fid, "  \\begin{tabular}{c|cc|cc|cc}\n");

  fprintf(fid, "    Depth & \\multicolumn{2}{c|}{Information Gain} &\n");
  fprintf(fid, "    \\multicolumn{2}{c|}{Majority Error} &\n");
  fprintf(fid, "    \\multicolumn{2}{c}{GINI Index} \\\\\n");
  fprintf(fid, "          & Training & Test     & Training & Test     & ");
  fprintf(fid, "Training & Test     \\\\ \\hline\n");
  for r = 1:rows(e)
    fprintf(fid, "    %5d", r)
    for c = 1:columns(e)
      fprintf(fid, " & %8d", e(r, c))
    end
    fprintf(fid, " \\\\ \\hline\n");
  end

  fprintf(fid, "  \\end{tabular}\n");
  fprintf(fid, "  \\caption{Error rates for Problem 2, part b.}\n");
  fprintf(fid, "  \\label{tab:p2b}\n");
  fprintf(fid, "\\end{table}\n");
  fclose(fid);
endfunction
