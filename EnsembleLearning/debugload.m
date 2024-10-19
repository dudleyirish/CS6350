%%
%% load.m a debug script to load the data into Octave for debugging.
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

outf = stdout;
		 
trainfile = "../../bank/train.csv";
testfile = "../../bank/test.csv";
Train = Practice_CleanData(trainfile, "banktrain.mat", attr_values, ...
			     thresholds);
Test = Practice_CleanData(testfile, "banktest.mat", attr_values, thresholds);
