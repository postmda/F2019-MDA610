### Assignment 11 (due November 26)
1. Read [Titanic Best Working Classifier](https://www.kaggle.com/sinakhorami/titanic-best-working-classifier/comments).
	- This is a comprehensive Jupyter notebook that will help you understand the basic ideas of feature engineering, i.e., data cleaning and preparation. You can download the notebook by clicking the `...`  button at the upper right corner and then selecting `Download Code`. 
	- An overview of Kaggle competitions and the Titanic data is available at https://www.kaggle.com/c/titanic/overview.
	- The data files `train.csv` and `test.csv` can be downloaded from the current folder in the class repository. 
	- Descriptions of the variables in the data sets are available at https://www.kaggle.com/c/titanic/data.
	- Read the `Feature Engineering` and `Data Cleaning` sections in the notebook. 
	- In the `Feature Engineering` section, every field (column) is examined and/or preprocessed. 
	- In the `Data Cleaning` section, categorical data are mapped into numerical ones, while some fields are dropped. 
	- Some notes
		- Code Cell 1: you will have to revise the path of the .csv files so as to load the data. 
		- Code Cell 3: `full_data` is a list of two DataFrames `train` and `test`. 
		- Code Cell 4: a new field `FamilySize` is added into both DataFrames.
		- Code Cell 7: `pd.qcut` is a pandas method to discretize continuous numerical data into categories (bins) so that each bin has an equal frequency.
		- Code Cell 8: `astype` is a method to convert the data type of a Series. `pd.cut` is a pandas method to discretize continuous numerical data into categories (bins) so that each bin has the same width.
		- Code Cell 9: The `get_title` function returns the title part (such as 'Dr', 'Mr' or 'Mrs') in a text. `pd.crosstab` is a pandas method to create a contingency table with a row variable and a column variable. 
		- Code Cell 10: `replace` is a Series/DataFrame method that replaces values.
2. Download `Titanic.ipynb`, `train.csv` and `test.csv` in the current folder to your computer. Follow the TODO instructions in the notebook to write Python code snippets and save the notebook file with the output of each code cell. After you finish programming, create folder `hw11` and copy the notebook file to the `hw11` folder. Then upload the folder to your remote repo. Finally, email the URL of your remote repo to the instructor.
3. To prepare for the second in-class quiz, review Homework Assignments 7 to 10. 
