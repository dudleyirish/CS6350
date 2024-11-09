%% usage: [w, e, u] = TrainPerceptron (X, Y, T, r)
%%
%% Trains a perceptron using the "standard" algorithm
%%
%% X -- augmented training data, transposed so each example is a column
%% Y -- labels
%% T -- Number of epochs.
%% r -- training rate
%%
%% returns:
%% w - the augmented wait vector
%% e - the training error.
%%
function [w, errcnt, U] = TrainPerceptron (X, Y, T, r)
  %% quiet mode
  quiet = 1;
  %% Prepare the data
  %% X is transposed so that each example is a column vector
  m = columns(X);
  d = rows(X);

  w = zeros(d,1);  %% initialize the Augmented weights
  U = [];
  for epoch = 1:T
    updates = 0;
    if !quiet
      if epoch > 1
	printf("\n\n");
      end
      printf("Epoch %d:\n", epoch);
    end
    %% shuffle the training data
    V = randperm(m);
    S = X(:, V);
    Ys = Y(V,:);
    for i=1:m
      ## if !quiet
      ## 	printf("    Ys(%d) = %d, w'*S(:,%d) = %f\n", ...
      ## 	       i, Ys(i), i, w'*S(:,i));
      ## end
      if Ys(i)*w'*S(:,i) <= 0
	update = r*(Ys(i)*S(:,i));
	w = w + update ;
	updates = updates + 1;

	if !quiet
	  printf("      S(:,i) = [%f", S(1,i));
	  printf(", %f", S(2:end,i));
	  printf("]\n");
	  printf("      Update = r*(%d)*S(i) = [%f", Ys(i), update(1));
	  printf(", %f", update(2:end));
	  printf("]\n");
	  printf("      w = [%f", w(1));
	  printf(", %f", w(2:end));
	  printf("], ErrorCount = %d\n\n", ErrorCount(w, S, Ys));
	end
      end
    end

    e = ErrorCount(w, S, Ys);
    U = [U; updates];
    
    if !quiet
      printf("  updates = %d, ||w||: %f, e = %d(%f)\n", ...
	     updates, sqrt(sumsq(w)), e, e/m);
      ## printf("epoch: %d, updates = %d, w: [%f", epoch(1), updates, w(1));
      ## printf(", %f ", w(2:end)); printf("], e = %d\n", e);
    end
    if e == 0
      break;
    end
  end
  errcnt = e;
end
