# BlogFeedbackPrediction
Regression models with feature selection to predict the number of comments
Code 1:
In this code, the regression models from sklearn were used to predict the number of comments based on all the features. (Uncomment Line 15 and 21 randomly permuted the columns)
The values in the table are tested on test data at the interval of 15 days till after 2 months

Code 2: 
This code is a python notebook. This code does feature selection on the training data first by the filter method based on correlation. Further, the filter and wrapper method are used together. The Recursive Feature elimination using Cross-correlation is used for the wrapper method of feature selection

DataAnalysis.R:
This code is to analyze the data in R.(I find it easier than Python.)

The rest of the csv files are the train and test data. The test data used in code is blogData_test-2012.02.01.00_00.csv. 

Report.pdf is the final report. The Latex source for the report is in the folder Term Project. It contains all three submissions Proposal, Midway and Final. Since, the references and images have been used interchangeably, I have kept it as it is. 

The Final.pptx is the final presentation. 

The related work paper is attached as Feedback Prediction of Blogs.pdf. The link of the project I have used as baseline is included in the Report. 

Source of data: http://archive.ics.uci.edu/ml/datasets/BlogFeedback
