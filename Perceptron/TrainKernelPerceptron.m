%% usage: [A, b] = TrainKernelPerceptron (X, Y, T, gamma)
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
function [A, b] = TrainKernelPerceptron (X, Y, T, gamma)
  %% quiet mode
  quiet = 1;
  %% Prepare the data
  %% X is transposed so that each example is a column vector
  m = columns(X);
  d = rows(X);

  w = zeros(d,1);  %% initialize the Augmented weights
  U = [];
  A = zeros(rows(X), 1);
  b = 0;
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
      a = sum(exp(abs(A .* X - X(i,:)).^2/gamma)) + b;

      if Ys(i)*a <= 0
	A(i) = A(i) + Ys(i);
	b = b + Ys(i);

	if !quiet
	end
      end
    end
  end
end
