%% usage: [e, W, C] = practice2b (trainfile, testfile)
%%
%%
function [e, W, C] = practice2b (trainfile, testfile)
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
  X = Train(:,1:end-1);
  X = [X, ones(m, 1)]';
  Y = Train(:,end) * 2 - 1;

  [W, C, e, u] = TrainVotedPerceptron(X, Y, 10, 1);
  for i=1:rows(W)
    printf("w(%d)=[%f", i, W(1,i));
    printf(", %f", W(2:end,i));
    printf("], C = %d\n", C(i));
  end
  printf("Training error = %f\n", e);

  d = columns(Test) - 1;
  m = rows(Test);
  X = Test(:,1:end-1);
  X = [X, ones(m, 1)]';
  Y = Test(:,end) * 2 - 1;
  pe = VotedErrorCount(W, C, X, Y);
  printf("Prediction error: %f\n", pe/m);

  latex2b (W, C);
endfunction
