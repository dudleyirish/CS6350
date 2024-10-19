%% usage: S = Practice_CleanSlump (filepath, ofile)
%%
%% filepath -- The input data file in csv format
%% ofile -- the output file write in octave mat format
%%
function S = Practice_CleanSlump (filepath, ofile)
  global outf
  S = [];
  if exist(ofile, "file")
    fprintf(outf, "Output file already exists, reading it.\n");
    tic()
    input = load(ofile);
    fprintf(outf, "Reading Octave file took %f secconds\n", toc());
    S = input.S;
  else
    fprintf(outf, "Output file does not exists, cleaning data file\n");
    tic()
    S = csvread("~/CS/CS6350/concrete+slump+test/slump_test.data", 1, 1);
    S = S(:,1:5);
    fprintf(outf, "Reading CSV file took %f secconds\n", toc());

    tic()
    save("-binary", ofile, "S");
    fprintf(outf, "Writing Octave file took %f secconds\n", toc());
  end
end
