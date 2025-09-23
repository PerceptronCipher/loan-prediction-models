"""
app.py
Simple Streamlit app to deploy the Loan Default Analysis model.
"""

import streamlit as st
import joblib
import numpy as np

# Load the model
model = joblib.load("Notebooks/models/linear_regression_model2.pkl")
# App Title
st.title("💰 Loan Total Due Prediction App")
st.write("Enter loan details below to predict total amount due:")

# User Inputs
loan_amount = st.number_input("Loan Amount ($)", min_value=0, max_value=100000, value=5000, step=100)
charges_pct = st.number_input("Charges Percentage (%)", min_value=0.0, max_value=50.0, value=10.0, step=0.5)
loan_duration = st.number_input("Loan Duration (days)", min_value=1, max_value=365, value=30, step=1)

# Convert inputs to numpy array
features = np.array([[loan_amount, charges_pct, loan_duration]])

# Prediction
if st.button("Predict Total Due"):
    prediction = model.predict(features)[0]
    st.success(f"Predicted Total Due: ${prediction:.2f}")