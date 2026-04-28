# NYC 311 Modeling Plan

**Date:** 4/28/26

## Goal
Predict how long a complaint takes to close and find what affects it.

## Data
- S3: s3://cmse495-lambjos3-nyc311-381491926400-us-east-1-an/modeling/resolution_time_modeling.csv
- Rows: 173,851  

## Features
- agency  
- borough  
- problem  
- incident_zip  
- day_of_week  
- hour_of_day  
- same_day_complaint_volume  

## Target
- days_to_close (number of days)  
- Most cases close in 0–2 days  

## Models
- Logistic Regression  
- Random Forest  
- Train/test split: 80/20  
- Metrics: accuracy, precision, recall  

## Results (Logistic Regression)
- Accuracy: 0.860  
- Precision: 0.909  
- Recall: 0.859 

## Notes
- Model works well for same-day predictions  
- Data is uneven, many fast closures  
- Features are simple, miss some real factors  

## SageMaker Comparison
- Task: predict days to close  
- Metrics: MAE, RMSE, R²  
- Better than baseline but similar to sklearn  
- Not needed for this size of data