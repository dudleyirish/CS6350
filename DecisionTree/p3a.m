%% usage: e = p3a (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% e - error rate from running the training data.
%%
function e = p3a (trainfile, testfile)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues
  attr_names = {'age'; 'job'; 'marital'; 'education';'default'; 'balance';
		'housing'; 'loan'; 'contact'; 'day'; 'month'; 'duration';
		'campaign'; 'pdays'; 'previous'; 'poutcome'; 'y'};
  attr_values = {{'numeric'};
		 {"admin.","unknown","unemployed","management","housemaid", ...
		  "entrepreneur","student","blue-collar","self-employed", ...
		  "retired","technician","services"};
		 {"married", "divorced", "single"};
		 {"unknown","secondary","primary","tertiary"};
		 {"yes","no"};
		 {'numeric'};
		 {"yes","no"};
		 {"yes","no"};
		 {"unknown","telephone","cellular"};
		 {'numeric'};
		 {'apr', 'aug', 'dec', 'feb', 'jan', 'jul', 'jun', 'mar', ...
		  'may', 'nov', 'oct', 'sep'};
		 {'numeric'};
		 {'numeric'};
		 {'numeric'};
		 {'numeric'};
		 {"unknown","other","failure","success"}
		};

  ## S = ReadBankData(trainfile);
  ## F = ones(rows(S), 1);
  ## printf("Learn the decision tree using fractional counts:\n\n");
  ## ID3(S, F, 5, attr_names, attr_values, 5, @FindSplitIG);
  ## printf("\nA textual representation of the tree:\n");
  ## WriteTree(Connectivity, NodeName, NodeLabel, NodeValue);
  ## printf("\n\nThe tree as a conjunction of prediction rules:\n");
  ## WriteCond(Connectivity, NodeName, NodeLabel, NodeValue);
  e = attr_values;
endfunction
