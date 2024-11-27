%% usage: practice2a ()
%%
%%
function [w, Xin, Yin] = practice2a ()
  if exist("trainfile", "var")
    Train = CleanBankNoteData(trainfile, "train.mat");
  else
    Train = CleanBankNoteData("~/CS/CS6350/bank-note/train.csv", "train.mat");
  end
  if exist("testfile", "var")
    Test = CleanBankNoteData(testfile, "test.mat");
  else
    Test = CleanBankNoteData("~/CS/CS6350/bank-note/test.csv", "test.mat");
  end


  %% Prepare the data
  %% Last column of S is the labels.
  d = columns(Train) - 1;
  m = rows(Train);
  Xin = Train(:,1:end-1);
  testXin = Test(:,1:end-1);

  scale_min = min(min(Xin), min(testXin));
  scale_max = max(max(Xin), max(testXin));

  Xscaled = (Xin - repmat(scale_min, size(Xin,1),1)) * ...
	    spdiags(1./(scale_max-scale_min)', 0, size(Xin,2), size(Xin,2));
  testXscaled = (testXin - repmat(scale_min, size(testXin,1),1)) * ...
		spdiags(1./(scale_max-scale_min)', 0, size(testXin,2), size(testXin,2));

  Xin = [Xscaled, ones(m, 1)];
  Yin = Train(:,end) * 2 - 1;
  TestXin = [testXscaled, ones(rows(Test), 1)];
  TestYin = Test(:,end) * 2 - 1;

  xi0 = 1;
  a = .25;
  T = 100;
  xi = xi0./(1+(xi0*1:T)/a);
  for C = [100/873, 500/873, 700/873]
    w = TrainSVMSGD(Xin, Yin, T, xi, C);
    printf("C = %s:\n", strtrim(rats(C)));
    printf("w = [%f %f %f %f], b = %f\n", w);
    training_error = ErrorCount(w, Xin, Yin)/rows(Xin);
    test_error = ErrorCount(w, TestXin, TestYin)/rows(TestXin);
    printf("Training Error: %f, Test Error: %f\n\n", ...
	   training_error, test_error);
  end
end
