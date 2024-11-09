%% usage: [w, c, e, u] = TrainVotedPerceptron (X, Y, T, r)
%%
%% Trains a voted perceptron using the "standard" algorithm
%%
%% X -- augmented training data, transposed so each example is a column
%% Y -- labels
%% T -- Number of epochs.
%% r -- training rate
%%
%% returns:
%% w - a vector of augmented weight vectors
%% c - the counts that corrispond with each weight vector
%% e - the training error.
%% u - number of updates;
%%
function [W, C, e, u] = TrainVotedPerceptron (X, Y, T, r)
  %% quiet mode
  quiet = 1;
  %% Prepare the data
  %% X is transposed so that each example is a column vector
  m = columns(X);
  C = [];
  W = [];
  c_m = 0;
  d = rows(X);

  w_m = zeros(d,1);  %% initialize the Augmented weights
  updates = 0;
  for epoch = 1:T
    if !quiet
      if epoch > 1
	printf("\n\n");
      end
      printf("Epoch %d:\n", epoch);
    end
    %% shuffle the training data
    V = randperm(columns(X));
    S = X(:, V);
    Ys = Y(V,:);
    for i=1:columns(X)
      ## if !quiet
      ## 	printf("    Ys(%d)*w_m'*S(:,%d) = %f\n", i, i, Ys(i)*w_m'*S(:,i))
      ## end
      if Ys(i)*w_m'*S(:,i) <= 0
	update = r*(Ys(i)*S(:,i));
	if c_m > 0
	  %% Save w_m
	  W = [W, w_m];
	  %% Save c_m
	  C = [C ; c_m];
	end;
	w_m = w_m + update ;
	updates = updates + 1;
	c_m = 1;

	if !quiet
	  printf("      S(:,%d) = [%f", i, S(1,i));
	  printf(", %f", S(2:end,i));
	  printf("]\n");
	  printf("      Update = r*(%d)*S(i) = [%f", Ys(i), update(1));
	  printf(", %f", update(2:end));
	  printf("]\n");
	  printf("      w = [%f", w_m(1));
	  printf(", %f", w_m(2:end));
	  if rows(W) > 0
	    printf("], ErrorCount = %d\n\n", VotedErrorCount(W, C, S, Ys));
	  else
	    printf("]\n\n");
	  end
	end
      else
	c_m = c_m + 1;
      end
    end

    e = VotedErrorCount(W, C, S, Ys);
  
    if !quiet
      printf("  updates = %d, ||w_m||: %f, error count = %d, error rate = (%f), size(W) = (%f, %f)\n", ...
	     updates, sqrt(sumsq(w_m)), e, e/m, size(W));
    end
    if e == 0
      break;
    end
  end
  printf("At end of function, c_m = %d\n", c_m);
  if c_m > 0
    %% Save w_m
    W = [W, w_m];
    %% Save c_m
    C = [C ; c_m];
  end;
  e = e/columns(X);
  u = updates;
end
