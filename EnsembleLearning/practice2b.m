%% 
%% usage: e = practice2b (trainfile, testfile, outputfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% outputfile - A text file that progress and debug information is writtent to.
%%
%% e - error rate from running the training data.
%%
function e = practice2b (trainfile, testfile, T, outputfile)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues outf
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
  thresholds = [38,    %% age
		 0,     %% job
		 0,     %% marital
		 0,     %% education
		 0,     %% default
		 452.5, %% balance
		 0,     %% housing
		 0,     %% loan
		 0,     %% contact
		 16,    %% day
		 0,     %% month
		 180,   %% duration
		 2,     %% compaign
		 189,   %% pdays
		 0,     %% previous
		 0,     %% poutcome
		 0];    %% y

  outf = fopen(outputfile, "w");
  if outf == -1
    error("Could not open output file");
  end
		 
  Train = Practice_CleanData(trainfile, "banktrain.mat", attr_values, ...
			     thresholds);
  Test = Practice_CleanData(testfile, "banktest.mat", attr_values, thresholds);

  fprintf(outf, "AdaBoost: 1 iteration.\n");
  if exist("adaboost1.m", "file")
    delete("adaboost*.m");
  end
  tic();
  D = [];
  At = ones(T, 1);
  for t = 1 %%:T
    S = Train(sort(randsample(rows(Train), 10)), :);
    Dt = ones(rows(S), 1) ./ rows(S);
    ID3(S, Dt, -1, attr_names, attr_values, columns(S), @FindSplitIG);
    classifier = sprintf("bag%03d", t);
    CreateClassifier(classifier, Connectivity, NodeName, NodeLabel, ...
		     NodeValue, attr_names);
    [Dt, Et, alphat] = ConstructNewWeights(Dt, Train, classifier);
    At(t) = alphat;
    D = [D Dt];
  end
  save("-binary", sprintf("D.mat", t), "D", "At");
  CreateFinalHypothesis("H_Final", "bag", At)
  fprintf(outf, "Training took %d minutes.\n", toc()/60);

  fclose(outf);

  e = Practice_RunTests(Train, Test, "H_Final");
endfunction
