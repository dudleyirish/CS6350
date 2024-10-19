%% 
%% usage: practice4c (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%%
%%
function practice4c (trainfile, testfile)
  names = {'Cement'; 'Slag'; 'Fly ash'; 'Water'; 'SP'; 'Coarse Aggr.'; 'Fine Aggr.'};

  %% "~/CS/CS6350/concrete/train.csv"
  S = csvread(trainfile);
  Train = S(:,1:7);
  train_y = S(:, end);
  %% "~/CS/CS6350/concrete/test.csv"
  S = csvread(testfile);
  Test = S(:,1:7);
  test_y = S(:, end);
  
  x = [Train, ones(53,1)]';
  %% Solve analytically
  w = inv(x*x')*(x*train_y);
  printf("weights: [%.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f]\n", w);

  %% Compute cost function on test data
  x = [Test, ones(rows(Test),1)]';
  test_cost = ComputeCost(w, x, test_y);
  printf("Test cost is %.4f\n", test_cost);
end
