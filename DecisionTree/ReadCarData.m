%% usage: S = ReadCarData (filepath)
%%
%%
function S = ReadCarData (filepath)
  row = 1;
  S = {};
  fid = fopen(filepath, 'r');
  while true
    txt = fgetl(fid);
    if txt == -1
      break;
    end
    cstr = strsplit(txt, ',');
    S = [S; cstr];
  end
  fclose(fid);
endfunction
