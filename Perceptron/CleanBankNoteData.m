%% usage: S = CleanBankNoteData (csvfile, matfile)
%%
%% csvfile -- input file
%% matfile -- output/cache file.
%%
function S = CleanBankNoteData (csvfile, matfile)
  if isfile(matfile)
    printf("Output file already exists, reading it.\n");
    tic();
    S = load(matfile).S;
    printf("Reading Octave file took %f secconds\n", toc());
  else
    printf("Output file does not exists, cleaning data file\n");
    tic();
    S = csvread(csvfile);
    printf("Reading CSV file took %f secconds\n", toc());

    tic();
    save("-binary", matfile, "S");
    printf("Writing Octave file took %f secconds\n", toc());
  end
end
