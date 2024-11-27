%% usage: practice3b ()
%%
%% This script assumes that the training and test data have been converting into
%% libsvm format and are in train.raw and test.raw.
%%
function practice3b ()
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

  %% Scale the data
  X = Train(:,1:end-1);
  Y = Train(:,end);

  testX = Test(:,1:end-1);
  testY = Test(:,end);

  scale_min = min(min(X), min(testX));
  scale_max = max(max(X), max(testX));

  Xscaled = (X - repmat(scale_min, size(X,1),1)) * ...
	    spdiags(1./(scale_max-scale_min)', 0, size(X,2), size(X,2));
  testXscaled = (testX - repmat(scale_min, size(testX,1),1)) * ...
		spdiags(1./(scale_max-scale_min)', 0, size(testX,2), size(testX,2));

  for gamma = [0.1, 0.5, 1, 5, 100]
    printf("        $%.1f$", gamma);
    for C = [100 500 700]
      options = sprintf('-q -t 2 -c %.4f -g %.4f', C/873, 1/gamma);
      %%printf('Options = #%s#\n', options);
      model = svmtrain(Y, Xscaled, options);
      [label, training_accuracy, dec] = svmpredict(Y, Xscaled, model, '-q');
      [label, test_accuracy, dec] = svmpredict(testY, testXscaled, model, '-q');
      printf(" & $%.2f$ & $%.2f$", ...
	     100 - training_accuracy(1), 100 - test_accuracy(1));
    end
    printf(" \\\\ \\hline\n");
  end
end
