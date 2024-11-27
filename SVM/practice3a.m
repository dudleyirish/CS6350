%% usage: practice3a ()
%%
%% This script assumes that the training and test data have been converting into
%% libsvm format and are in train.raw and test.raw.
%%
function [m1, m5, m7] =  practice3a ()
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

  Xscaled = (X - repmat(scale_min, size(X,1),1))*spdiags(1./(scale_max-scale_min)', 0, size(X,2), size(X,2));
  testXscaled = (testX - repmat(scale_min, size(testX,1),1))*spdiags(1./(scale_max-scale_min)', 0, size(testX,2), size(testX,2));

  %% Train a linear model, C = 100/873
  linear1_model = svmtrain(Y, Xscaled, '-q -t 0 -c 0.1145');
  printf("        $100/873$ & $%f$ & $%f$ & $%f$ & $%f$ & $%f$ \\\\\n", ...
	 linear1_model.SVs' * linear1_model.sv_coef, ...
	 -linear1_model.rho);

  %% Train a linear model, C = 500/873
  linear5_model = svmtrain(Y, Xscaled, '-q -t 0 -c 0.5727');
  printf("        $500/873$ & $%f$ & $%f$ & $%f$ & $%f$ & $%f$ \\\\\n", ...
	 linear5_model.SVs' * linear5_model.sv_coef, ...
	 -linear5_model.rho);

  %% Train a linear model, C = 700/873
  linear7_model = svmtrain(Y, Xscaled, '-q -t 0 -c 0.8018');
  printf("        $700/873$ & $%f$ & $%f$ & $%f$ & $%f$ & $%f$ \\\\\n", ...
	 linear7_model.SVs' * linear7_model.sv_coef, ...
	 -linear7_model.rho);

  %% return the models
  m1 = linear1_model;
  m5 = linear5_model;
  m7 = linear7_model;
endfunction
