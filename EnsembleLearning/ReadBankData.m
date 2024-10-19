%% usage: S = ReadBankData (filepath)
%%
%%
function S = ReadBankData (filepath)
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
    cstr{1} = str2num(cstr{1});
    cstr{6} = str2num(cstr{6});
    cstr{10} = str2num(cstr{10});
    cstr{12} = str2num(cstr{12});
    cstr{13} = str2num(cstr{13});
    cstr{14} = str2num(cstr{14});
    cstr{15} = str2num(cstr{15});
    S = [S; cstr];
  end
  fclose(fid);
endfunction
