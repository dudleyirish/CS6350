%% usage: practice2a(trainfile, testfile)
%%
%% This code is based on the matrix implementation from [Andrew
%% Ng](http://andrewng.com)'s [Machine Learning Course on
%% Coursera](https://www.coursera.org/learn/machine-learning/home/welcome).
%%
%% I also relied on https://github.com/massie/octave-nn.git by Matt Massie for
%% ideas on how to implement the algorithm in Octave.
%%
function practice2a()
  sigmoid = @(z) 1./(1 + exp(-z));
  dsigmoid = @(z) z.*(1-z);

  w1 = [-1 1;
	-2 2;
	-3 3];
  w2 = [-1 1;
	-2 2;
	-3 3];
  w3 = [-1 2 -1.5];
  %% Augment X for layer 0
  X = [1 1 1];
  z1 = [1 sigmoid(X * w1)];
  z2 = [1 sigmoid(z1 * w2)];
  y = sum(w3 .* z2);
  ystar = 1;

  %% Backpropagation
  L = 1/2*(y - ystar)^2;
  z2_error = (y - ystar) * w3;
  z2_delta = z2_error .* dsigmoid(z2);
  z1_error = z2_delta .* w2';
  z1_delta = z1_error .* dsigmoid(z1);
  %%
  printf("dLdy = %f\n", y - ystar);
  printf("dLdw3 = [%.4f %.4f %.4f]\n", dsigmoid(z2 .* w3));
  printf("dLdw2 = [%.4f %.4f %.4f\n", dsigmoid(z1 .* w2')(1,:));
  printf("         %.4f %.4f %.4f]\n", dsigmoid(z1 .* w2')(2,:));
  printf("dLdw1 = [%.4f %.4f %.4f\n", dsigmoid(X .* w1')(1,:));
  printf("         %.4f %.4f %.4f]\n", dsigmoid(X .* w1')(2,:));
end
