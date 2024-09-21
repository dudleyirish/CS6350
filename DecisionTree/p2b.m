%% usage: e = p2b (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% e - error rates from running the training and test data.
%%
function e = p2b (trainfile, testfile)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues
  attr_names = {'buying'; 'maint'; 'doors'; 'persons'; 'lug_boot'; 'safety'; ...
		'label'};
  attr_values = {{'vhigh', 'high', 'med', 'low'};
		 {'vhigh', 'high', 'med', 'low'};
		  {'2', '3', '4', '5more'};
		  {'2', '4', 'more'};
		  {'small', 'med', 'big'};
		  {'low', 'med', 'high'};
		  {'unacc', 'acc', 'good', 'vgood'}};

  S = ReadCarData(trainfile);
  T = ReadCarData(testfile);
  F = ones(rows(S), 1);

  printf("Learn different depth trees from 1 to 6 with information gain.\n");
  for depth = 1:6
    ID3(S, F, depth, attr_names, attr_values, 5, @FindSplitIG);
    name = sprintf("carig%d", depth);
    CreateClassifier(name, Connectivity, NodeName, NodeLabel, NodeValue, ...
		     attr_names);
  end
  ig_error_rates = p2b_RunTests(S, T, 'carig');

  printf("Learn different depth trees from 1 to 6 with majority error.\n");
  for depth = 5
    ID3(S, F, depth, attr_names, attr_values, 5, @FindSplitME);
    name = sprintf("carme%d", depth);
    CreateClassifier(name, Connectivity, NodeName, NodeLabel, NodeValue, ...
		     attr_names);
  end
  me_error_rates = p2b_RunTests(S, T, 'carme');

  printf("Learn different depth trees from 1 to 6 with GINI index.\n");
  for depth = 1:6
    ID3(S, F, depth, attr_names, attr_values, 5, @FindSplitGI);
    name = sprintf("cargi%d", depth);
    CreateClassifier(name, Connectivity, NodeName, NodeLabel, NodeValue, ...
		     attr_names);
  end
  gi_error_rates = p2b_RunTests(S, T, 'cargi');
  e = [ig_error_rates, me_error_rates, gi_error_rates];

  printf("Write the latex table to be included in solution.\n");
endfunction
