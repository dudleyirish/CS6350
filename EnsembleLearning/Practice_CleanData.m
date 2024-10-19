%% usage: S = Practice_CleanData (filepath, ofile, thresholds)
%%
%% filepath -- The input data file in csv format
%% ofile -- the output file write in octave mat format
%% thresholds -- The threshold to apply to numeric fields to convert them to
%%               boolean
%%
function S = Practice_CleanData (filepath, ofile, values, thresholds)
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

    %% Setup to convert to numbers
    job = containers.Map(values{2}, 1:12);
    marital = containers.Map(values{3}, 1:3);
    education = containers.Map(values{4}, 1:4);
    contact = containers.Map(values{9}, 1:3);
    month = containers.Map(values{11}, 1:12);
    poutcome = containers.Map(values{16}, 1:4);

    %% Read the data file:
    row = 1;
    fid = fopen(filepath, 'r');
    while true
      txt = fgetl(fid);
      if txt == -1
	break;
      end
      cstr = strsplit(txt, ',');
      cnum = zeros(1,rows(cstr));
      %% Convert strings to numbers and numeric to bools
      cnum(1) = 2*(str2num(cstr{1}) > thresholds(1)) - 1;
      cnum(2) = job(cstr{2});
      cnum(3) = marital(cstr{3});
      cnum(4) = education(cstr{4});
      cnum(5) = yesno2plusminus(cstr{5});
      cnum(6) = 2*(str2num(cstr{6}) > thresholds(6)) - 1;
      cnum(7) = yesno2plusminus(cstr{7});
      cnum(8) = yesno2plusminus(cstr{8});
      cnum(9) = contact(cstr{9});
      cnum(10) = 2*(str2num(cstr{10}) > thresholds(10)) - 1;
      cnum(11) = month(cstr{11});
      cnum(12) = 2*(str2num(cstr{12}) > thresholds(12)) - 1;
      cnum(13) = 2*(str2num(cstr{13}) > thresholds(13)) - 1;
      cnum(14) = 2*(str2num(cstr{14}) > thresholds(14)) - 1;
      cnum(15) = 2*(str2num(cstr{15}) > thresholds(15)) - 1;
      cnum(16) = poutcome(cstr{16});
      cnum(17) = yesno2plusminus(cstr{17});
      S = [S; cnum];
    end
    fclose(fid);
    fprintf(outf, "Reading CSV file took %f secconds\n", toc());

    tic()
    save("-binary", ofile, "S");
    fprintf(outf, "Writing Octave file took %f secconds\n", toc());
  end
end

function out = yesno2plusminus(in)
  out = -1;
  if strcmp(in, 'yes')
    out = 1;
  end
end
