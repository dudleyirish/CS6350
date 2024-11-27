%% usage: practice3c ()
%%
%%
function [m01, m05, m10, m50, m100] = practice3c ()
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

      if C == 500
	if gamma == 0.1
	  SVs01 = model.SVs;
	  m01 = model;
	elseif gamma == 0.5
	  SVs05 = model.SVs;
	  m05 = model;
	elseif gamma == 1
	  SVs10 = model.SVs;
	  m10 = model;
	elseif gamma == 5
	  SVs50 = model.SVs;
	  m50 = model;
	elseif gamma == 100
	  SVs100 = model.SVs;
	  m100 = model;
	endif
      end
      
      ## printf("        $%d/873$ & $%.1f$ & $%f$ & $%f$ \\\\\n", ...
      ## 	     C, gamma, model.nSV);
      printf(" & $%d$ & $%d$", ...
	     model.nSV);
    end
    printf(" \\\\\n");
  end
  printf("        $0.1 \\rightarrow 0.5$ & $%d$ \\\\\n", ...
	 nnz(sort(SVs01) == sort(SVs05(1:rows(SVs01),:))));
  printf("        $0.5 \\rightarrow 1.0$ & $%d$ & \\\\\n", ...
	 nnz(sort(SVs05) == sort(SVs10(1:rows(SVs05),:))));
  printf("        $1.0 \\rightarrow 5.0$ & $%d$ & \\\\\n", ...
	 nnz(sort(SVs10) == sort(SVs50(1:rows(SVs10),:))));
  printf("        $5.0 \\rightarrow 100$ & $%d$ & \\\\\n", ...
	 nnz(sort(SVs50) == sort(SVs100(1:rows(SVs50),:))));
end
