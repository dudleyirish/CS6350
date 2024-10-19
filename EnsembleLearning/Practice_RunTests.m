%% usage: E = Practice_RunTests (S, T, classifier)
%%
%%
function E = Practice_RunTests (S, T, classifier)
  global outf;

  fh = str2func(classifier);
  training_err = 0;
  for r = 1:rows(S)
    l = fh(S(r, :));
    if S(r, end) != l
      training_err = training_err + 1;
    end
  end
  test_err = 0;
  for r = 1:rows(T)
    l = fh(T(r, :));
    if T(r, end) != l
      test_err = test_err + 1;
    end
  end
  printf("%s: Training Error = %d/%d, Test Error = %d/%d\n", ...
	 classifier, training_err, rows(S), test_err, rows(T));
  E = [training_err/rows(S), test_err/rows(T)];

endfunction
