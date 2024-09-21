This folder contains the code for "Decision Tree Practice", Homework 1

The algorithm is implemented in GNU Octave.  The Octave syntax is
largely compatible with Matlab.  I have tried to make sure to use only
compatible constructs and have tried to test the code to make sure
that it runs on MATLAB as well, but minor syntax errors might arise.

Contents:

The files p2a.m, p2b.m, p2c.m, p3a.m, p3b.m, p3c.m each implement the
function which corrisponds to the name of the file.  These function
performs the task each part of each problem.  The output is written to
a corrisponding .txt file.  (Additional .tex files may be generated to
be incorporated into the homework solution.)

CreateClassifier.m -- a function to create an Octave classifier
function based on the tree.

FindSplitGI.m, FindSplitIG.m, FindSplitME.m implement the split
function using the gini index, information gain, and majority error
measures respectively.

GI.m, H.m, ME.m implement functions to compute the gini index,
entropy, and majority error respectively.

ID3.m - Contains the implementation of the AD3 algorithm.  This
function takes a function handle to the function which find the
attribute to split on.

ReadBankData.m - A function to read the bank training/test data.

ReadCarData.m -  A function to read the car training/test data.

WriteCond.m write the tree in the format of a COND rule.

WriteS.m writes the data in a human readable format

WriteTree.m writes a textual representation of the tree.

cellmode - Finds the mode in a cell array.

p2a.m - A function that takes the input file names as arguments and
performs the tests for part a.

p2b.m - A function that takes the input file names as arguments and
performs the tests for part b.  Generates the error rate table into
p2b_error.tex which is included in the homework solution.

p3a.m - A function that takes the input file names as arguments and
performs the tests for part a.
