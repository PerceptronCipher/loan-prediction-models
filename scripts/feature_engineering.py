"""
Feature Engineering Script
Altough the dataset is cleaned and engineered already in postgresql, this script performs additional feature engineering steps to prepare the data for machine learning models.
This script:
1. Loads the cleaned dataset (from data_cleaning.py output).
2. Handles missing values (example: fills employment_status with the most common value).
3. Creates new useful features for machine learning:
   - Binary feature for "large loans" (loans above 75th percentile).
4. Prepares the dataset for regression models.
"""

import pandas as pd

# Load the cleaned dataset
data = pd.read_csv("localfilepath/cleaned_data.csv")
print(data.shape)
data.info

# 2. Fill missing values in employment_status_clients
if "employment_status_clients" in df.columns:
    most_common_status = df["employment_status_clients"].mode()[0]
    df["employment_status_clients"] = df["employment_status_clients"].fillna(most_common_status)
    print(f"Filled missing employment_status_clients with: {most_common_status}")

""" logistic Regression Considerations to avoid noises """

# 3. Create binary feature: is_large_loan
cutoff = df["loanamount"].quantile(0.75)  # 75th percentile
df["is_large_loan"] = (df["loanamount"] > cutoff).astype(int)
print(f"\n75th percentile loan amount cutoff = {cutoff}")
print("Distribution of large loan flag:")
print(df["is_large_loan"].value_counts(normalize=True))

# 4. Save the engineered dataset for modeling
output_path = "localfilepath/featured_data.csv"
df.to_csv(output_path, index=False)
print(f"\nFeature engineering complete. File saved to: {output_path}")


# Save the engineered dataset
data.to_csv("localfilepath/engineered_data.csv", index=False)

