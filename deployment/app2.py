"""
app.py
Simple Streamlit app to deploy the Loan Default Analysis model.
"""

import streamlit as st
import joblib
import numpy as np

model = joblib.load("Notebooks/models/multiple_linear_regression_model.pkl")

# Make prediction to authenticate the loaded model 
new_data = np.array([[5000, 10, 30]])  # [loanamount, charges_pct, loan_duration]
prediction = model.predict(new_data)
print(f"Predicted totaldue: {prediction[0]}")


# App Title
st.title("💰 Loan Total Due Prediction App")
st.write("Enter loan details below to predict total amount due:")

# User Inputs
loan_amount = st.number_input("Loan Amount ($)", min_value=0, max_value=1000000, value=5000, step=500)
charges_pct = st.number_input("Charges Percentage (%)", min_value=0.0, max_value=50.0, value=10.0, step=0.5)
loan_duration = st.number_input("Loan Duration (days)", min_value=1, max_value=365, value=30, step=1)

# Convert inputs to numpy array
features = np.array([[loan_amount, charges_pct, loan_duration]])

# Prediction
if st.button("Predict"):
    prediction = model.predict(features)[0]
    st.success(f"📌 Predicted Value: {prediction:.2f}")