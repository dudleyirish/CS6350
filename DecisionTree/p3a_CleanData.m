%% usage: S = p3a_CleanData (filepath)
%%
%%
function S = p3a_CleanData (filepath, ofile, thresholds)
  S = {};
  if exist(ofile, "file")
    printf("Output file already exists, reading it.\n");
    tic()
    input = load(ofile);
    fprintf("Reading Octave file took %f secconds\n", toc());
    S = input.S;
  else
    printf("Output file does not exists, cleaning data file\n");
    tic()

    %% Read the data file:
    row = 1;
    S = {};
    fid = fopen(filepath, 'r');
    while true
      txt = fgetl(fid);
      if txt == -1
	break;
      end
      cstr = strsplit(txt, ',');
      %% Convert numeric columns
      cstr{1} = str2num(cstr{1}) > thresholds(1);
      cstr{6} = str2num(cstr{6}) > thresholds(6);
      cstr{10} = str2num(cstr{10}) > thresholds(10);
      cstr{12} = str2num(cstr{12}) > thresholds(12);
      cstr{13} = str2num(cstr{13}) > thresholds(13);
      cstr{14} = str2num(cstr{14}) > thresholds(14);
      cstr{15} = str2num(cstr{15}) > thresholds(15);
      S = [S; cstr];
    end
    fclose(fid);
    fprintf("Reading CSV file took %f secconds\n", toc());

    tic()
    save("-binary", ofile, "S");
    fprintf("Writing Octave file took %f secconds\n", toc());
  end
end
