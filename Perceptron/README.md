This directory contains the code for Homework 3, Practice.

CleanBankNoteData.m       - Reac the back note data set and store
	clean data into a Octave mat file cache.
ErrorCount.m              - Using a weight vector, count the number of
	misclassifications.
PlotBoundary.m            - Plot a boundry line, useful for
	visualizing 2d data.
TrainAveragedPerceptron.m - Train a perceptron using the "averaged" algorithm.
TrainPerceptron.m         - Train a perceptron using the "standard" algorithm.
TrainVotedPerceptron.m    - Train a perceptron using the "voted" algorithm.
VotedErrorCount.m         - Take a matrix of voted weight vectors and
	find the number of misclassifications.
X_Intercept.m             - Compute the X intercept of a boundary line
Y_Intercept.m             - Compute the Y intercept of a boundary line
latex2b.m                 - Output a voted weight matrix and counts
	ready to be formated by latex.
practice2a.m              - Function to perform computations for 2a
practice2b.m              - Function to perform computations for 2b
practice2c.m              - Function to perform computations for 2c

The practace2a, practace2b, and practace2c functions take the file
paths to the training and test data as arguments.  To rerun the code
for a problem use something like:

  practice2a("path to training data", "path to test data");
  
If the paths are not specified, they default to the locations in my
development environment.
