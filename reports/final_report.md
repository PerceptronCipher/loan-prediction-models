Final Report
Project Overview

This project set out to analyze loan repayment patterns and predict financial obligations using machine learning. The dataset included details such as loan amounts, charges, client employment status, and loan duration.
The focus was on three modeling approaches: Simple Linear Regression, Multiple Linear Regression, and Classification Models (Logistic Regression, Random Forest, and XGBoost). The work involved careful data preparation, exploratory analysis, model development, and evaluation.


Data Preparation

The dataset required several steps before modeling:
Missing values, such as in the employment_status_clients column, were filled using the most frequent category.
Categorical features like employment status were encoded numerically (e.g., “Employed,” “Self-Employed,” “Unemployed”) so the models could process them.


Data was split into training and test sets for fair evaluation.

Because the classification target was highly imbalanced, techniques such as using class_weight="balanced" in logistic regression were applied.

Exploratory Analysis

Initial exploration revealed that:

Larger loan amounts and longer durations were more likely associated with repayment difficulties.
Employment status influenced repayment behavior, with unemployed clients carrying higher risk.
The dataset was skewed toward one class in the target variable, creating challenges for classification models.

Model Training and Evaluation
Linear Regression
A simple linear regression model was built using loan amount as the predictor. Results showed an excellent fit:
Slope (Coefficient): 1.115
Intercept: 1164.13
R² Score: 0.99
Mean Squared Error: ~1.06 million
This indicates that nearly all variation in repayment amount could be explained by loan amount alone.


Multiple Linear Regression
To capture more realistic relationships, multiple linear regression was trained using three predictors: loan amount, charges percentage, and loan duration. The results were even stronger:
Coefficients:
Loan amount: 1.153
Charges percentage: 121.96
Loan duration: 7.74
Intercept: -2123.16
R² Score: 0.997
This model explained almost all the variation in repayment values, showing that incorporating charges and duration provided a more accurate picture of financial obligations than a single predictor.


Logistic Regression
For classification, logistic regression initially struggled due to class imbalance. While recall was extremely high for one class, it almost entirely ignored the minority class. After applying class weights, the model stabilized somewhat:
Accuracy: ~0.55
Precision: ~0.85
Recall: ~0.54
F1 Score: ~0.66
However, the overall performance still lagged behind more advanced models.


Discussion
The regression models performed very well, especially multiple regression, which demonstrated how additional features enhanced predictive power. Logistic regression, even with adjustments, struggled to cope with the dataset’s imbalance.


Conclusion
Linear Regression: Excellent fit, with R² of 0.99.
Multiple Regression: Even stronger, with R² of 0.997, and clear coefficient interpretation.
Classification: Logistic regression was weak, but Random Forest and XGBoost could proved to be more effective, with Future Work like:

Further tune Random Forest and XGBoost hyperparameters for maximum performance.
Engineer additional features that might capture repayment risk more deeply.
Address dataset imbalance with methods like SMOTE or by gathering more balanced samples.
Deploy the strongest model (XGBoost) with a simple web app interface for real-world usability.


Additionally, Visualization was done in tableau which provides trends and borrower characteristics and even made future predictions.