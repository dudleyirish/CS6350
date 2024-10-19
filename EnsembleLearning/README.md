This directory contains an implementation of decision tree based
machine learning in Octave.

ComputeCost.m -- Compute the cost function value
ComputeGradient.m -- Compute the gradient
ComputeWeightedError.m - Compute the weighted error
ConstructNewWeights.m - Construct new weights
CreateClassifier.m - Create a classifier function in a file.
CreateFinalHypothesis.m - Create the final hypothesis function in a file.
FindSplitGI.m - Find the attribute to split on using Gini index
FindSplitIG.m - Find the attribute to split on using information gain
FindSplitME.m - Find the attribute to split on using maximum error
GI.m - compute Gini index
H.m - compute entropy
ID3.m - implementation of the ID3 algorithm
ME.m - computer maximum error
Practice_CleanData.m - Read the bank data.  Clean it and convert to
	numerical values.
Practice_RunTests.m - run the tests and collect the error rate.
WriteCond.m - write the conditional values from data in the tree.
WriteTree.m - write the tree in a readable text format.
cellmode.m - compute the mode of a cell array
p3a.m - perform tasks required for problem 3a
p3a_CleanData.m - clean the bank data for problem 3a
p3a_RunTests.m - Run the tests for problem 3a
practice2a.m - perform tasks for problem 2a
practice2b.m - perform tasks for problem 2b
randsample.m - randsample function from statistics package

To run the code for any problem call the corrisponding function with
the required parameters.  All parameters are described in the file
header.  Typically they are the path to the training data file, the
path to the test data file, any additional parameters as described in
the header and the name of a output file to contain the required
incremental result output.
