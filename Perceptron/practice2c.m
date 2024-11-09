%% usage: e = practice2c (trainfile, testfile)
%%
%%
function e = practice2c (trainfile, testfile)
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

  [w, e, u] = TrainAveragedPerceptron(X, Y, 10, 1);
  printf("w =[%f", w(1));
  printf(", %f", w(2:end));
  printf("]\n");
  printf("Training error = %f\n", e);

  d = columns(Test) - 1;
  m = rows(Test);
  X = Test(:,1:end-1);
  X = [X, ones(m, 1)]';
  Y = Test(:,end) * 2 - 1;
  pe = ErrorCount(w, X, Y);
  printf("Prediction error: %f\n", pe/m);

end
