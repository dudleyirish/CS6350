%%
%% debugload.m a debug script to load the data into Octave for debugging.
%%
names = {'Cement'; 'Slag'; 'Fly ash'; 'Water'; 'SP'; 'Coarse Aggr.'; 'Fine Aggr.'};

trainfile = "~/CS/CS6350/concrete/train.csv";
S = csvread(trainfile);
Train = S(:,1:7);
train_y = S(:, end);
testfile = "~/CS/CS6350/concrete/test.csv";
S = csvread(testfile);
Test = S(:,1:7);
test_y = S(:, end);
