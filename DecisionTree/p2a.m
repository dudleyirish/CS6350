%% usage: e = p2a (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% e - error rate from running the training data.
%%
function [e, y] = p2a (trainfile, testfile)
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
  F = ones(rows(S), 1);
  printf("Learn the decision tree using fractional counts:\n\n");
  ID3(S, F, 5, attr_names, attr_values, 5, @FindSplitIG);
  printf("\nA textual representation of the tree:\n");
  WriteTree(Connectivity, NodeName, NodeLabel, NodeValue);
  printf("\n\nThe tree as a conjunction of prediction rules:\n");
  WriteCond(Connectivity, NodeName, NodeLabel, NodeValue);
endfunction
