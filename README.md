📊 Business Analytics Project with R: Customer Insights & Churn Prediction

This project explores a business dataset to derive customer insights and build a predictive model for churn using R. It demonstrates how data-driven decision-making can enhance customer retention strategies and improve business performance.

---

📌 Project Objectives

- Analyze customer demographics, satisfaction, spending patterns, and service usage.
- Explore key drivers of customer churn.
- Build a predictive model to classify customers likely to churn.
- Recommend strategic actions for reducing churn and improving customer satisfaction.

---

📂 Dataset Overview

The dataset contains 3,200 customer records and 12 variables, including:

| Variable                  | Description                                             |
|---------------------------|---------------------------------------------------------|
| customer_id              | Unique identifier for each customer                    |
| age                      | Customer’s age in years                                |
| gender                   | Male / Female                                          |
| region                   | Customer’s location (North, South, East, West)         |
| monthly_charges          | Monthly bill amount (USD)                              |
| total_purchases          | Total number of purchases made                         |
| avg_purchase_value       | Average amount per purchase (USD)                      |
| satisfaction_score       | Self-reported score (1 to 5)                           |
| tenure                   | Length of relationship in months                       |
| customer_service_calls   | Number of times customer contacted service             |
| contract_type            | Type of contract (Monthly, Yearly)                     |
| churn                    | Whether the customer left (Yes/No)                     |

---

🧠 Key Insights

- Churn rate is significantly higher among monthly contract customers.
- Low satisfaction scores are strong predictors of churn.
- Customers making frequent service calls are more likely to churn.
- Younger customers and those with low tenure show higher churn rates.

--- 

## 📈 Predictive Model

A Logistic Regression model was trained to predict churn. Key predictors:

- Age  
- Monthly Charges  
- Satisfaction Score  
- Tenure  
- Contract Type  
- Average Purchase Value  
- Customer Service Calls

🎯 Model Performance (Confusion Matrix Output):
- High accuracy (80%) and good class separation
- Useful for identifying high-risk customers

---

## 💼 Business Recommendations

- Offer discounts to convert monthly users to yearly contracts.
- Improve customer service quality and reduce call friction.
- Focus retention strategies on low tenure, low satisfaction customers.
- Launch customer satisfaction surveys regularly.

---

## 🛠 Technologies Used

- R, Excel  
- `tidyverse`, `caret`, `ggplot2`, `corrplot`, `janitor`, `dplyr`

---

## 📁 Folder Structure

```
📦 Customer_Churn_Analysis_R/
├── 📄 customer_churn_code.R		      # Full R script with analysis & modeling
├── 📄 customer_data.xlsx              	      # Dataset (3,200 rows, 12 columns)
├── 📄 README.md                             # Project overview & insights
└── 📁 Screenshots                           # Saved visualizations
```

---

## 👨‍💻 Author

Meer Tozammel Hossain  
Statistics Department  
University of Dhaka
Junior Research Fellow (BDRS)  
Portfolio Using R
Status: Complete
---