# Direct database connection to pgAdmin
from urllib.parse import quote_plus
import pandas as pd
from sqlalchemy import create_engine

# connection details (replace with your data)
username = "**********************"
password = "**********"
host = "localhost"
port = "****"
database = "loan_analysis"

# URL-encode the password to handle special characters if present e.g @, #
password_encoded = quote_plus(password)

# create connection string with encoded password
engine = create_engine(f"postgresql+psycopg2://{username}:{password_encoded}@{host}:{port}/{database}")

# load loan_analysis table into pandas
df = pd.read_sql("SELECT * FROM loan_analysis", engine)

# data inspection
print(df.shape)
print(df.head())
df.describe()
df.info()

# drop columns with more than 30% missing values 
df = df.drop(["bank_branch_clients", "level_of_education_clients", "referredby"], axis=1)
df.info()

# data to csv
df.to_csv("localfilepath/cleaned_data.csv", index=False)
