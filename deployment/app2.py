"""
app.py
Simple Streamlit app to deploy the Loan Default Analysis model.
"""

import streamlit as st
import joblib
import numpy as np

# Load the model
import joblib

model = joblib.load(r"localfilepath.pkl")


# Make prediction to authenticate the loaded model 
new_data = np.array([[5000, 10, 30]])  # [loanamount, charges_pct, loan_duration]
prediction = model.predict(new_data)
print(f"Predicted totaldue: {prediction[0]}")


# App Title
st.title("📊 Loan Default Prediction App")

st.write("Enter loan details below to predict outcome:")

# User Inputs
loan_amount = st.number_input("Loan Amount", min_value=0, max_value=1000000, value=20000, step=500)
loan_duration = st.number_input("Loan Duration (months)", min_value=1, max_value=60, value=12, step=1)
repayment_delay = st.number_input("Repayment Delay (days)", min_value=0, max_value=365, value=0, step=1)

# Convert inputs to numpy array (1 row with 3 columns)
features = np.array([[loan_amount, loan_duration, repayment_delay]])

# Prediction
if st.button("Predict"):
    prediction = model.predict(features)[0]
    st.success(f"📌 Predicted Value: {prediction:.2f}")