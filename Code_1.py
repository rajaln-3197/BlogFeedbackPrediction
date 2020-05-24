import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.ensemble import AdaBoostRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn import metrics
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
import math

filename = "blogData_train.csv"
train_data = pd.read_csv(filename,header=None)
#train_data = train_data.iloc[np.random.permutation(len(train_data))]
train_output = train_data[len(train_data.columns)-1]
del train_data[len(train_data.columns)-1]

filename = "blogData_test-2012.02.01.00_00.csv"
test_data = pd.read_csv(filename,header=None)
#test_data = test_data.iloc[np.random.permutation(len(test_data))]
test_output = test_data[len(test_data.columns)-1]
del test_data[len(test_data.columns)-1]

reg = LinearRegression()
rf = RandomForestRegressor()
gradBoost = GradientBoostingRegressor()
ada = AdaBoostRegressor()

#n_estimators=500

regressors = [reg,rf,gradBoost,ada]
regressor_names = ["Linear Regression","Random Forests","Gradient Boosting","Adaboost"]

#regressors = ada
#regressor_names = "Adaboost"

for regressor,regressor_name in zip(regressors,regressor_names):
    
    regressor.fit(train_data,train_output)
    predicted_values = regressor.predict(test_data)
    predicted = np.clip(predicted_values, 0,5000)

    counter = 0
    predicted = pd.DataFrame(data = predicted_values, index = None, columns = None)
    top = pd.concat([test_output,predicted], axis=1, sort=False, ignore_index=True)
    top = top.sort_values(0, ascending=False)
    for i in range(10):
        if math.ceil(top.iloc[i,0])== math.ceil(top.iloc[i,1]):
            counter = counter+1

    print ("Mean Absolute Error for ",regressor_name," : ",metrics.mean_absolute_error(test_output,predicted_values))
    print ("Median Absolute Error for ",regressor_name, " : ",metrics.median_absolute_error(test_output,predicted_values))
    print ("Mean Squared Error for ",regressor_name, " : ",metrics.mean_squared_error(test_output,predicted_values))
    print ("Max Error for ",regressor_name, " : ",metrics.max_error(test_output,predicted_values))
    print ("R2 score for ",regressor_name, " : ",metrics.r2_score(test_output,predicted_values))
    print ("HIT@10 for ",regressor_name, " : ",counter)
    print("\n")
