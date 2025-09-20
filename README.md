# Loan Analysis & Prediction Project

Built a complete loan analysis system from raw data to working web app. Covers everything from SQL data prep to deployed machine learning models.

## What I Did
1. **SQL Work**: Combined 3 messy datasets, created new features, cleaned everything up
2. **Tableau Dashboards**: Made charts showing loan trends and borrower patterns
3. **Python Models**: Built models to predict loan amounts and spot risky loans
4. **Web App**: Deployed working app so people can actually use the models

## The Models
- **Simple Linear Regression**: Basic model using just loan amount
- **Multiple Linear Regression**: Uses loan amount, charges, and duration - gets 99.7% accuracy
- **Logistic Regression**: Predicts if loans will be good or bad - had to fix class imbalance issues

## Results That Actually Matter
**Amount Prediction:** Works great - can predict what someone will owe with 99.7% accuracy.

**Risk Classification:** Started terrible (missed 99% of bad loans), got much better after balancing the data. Now catches over half the risky loans instead of basically none.

## What's In Here
- `notebooks/`: All the Python analysis and model building
- `sql/`: Queries I used to prep and combine the data  
- `models/`: The actual trained models
- `app/`: Web app for making predictions
- `tableau/`: Dashboards and visualizations

## Tools Used
- **SQL** for data engineering 
- **Tableau** for business dashboards
- **Python** for machine learning
- **Streamlit** for the web app

Real working system that goes from messy data to predictions you can actually use.