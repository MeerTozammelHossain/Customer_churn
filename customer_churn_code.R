#Load Required Libraries
library(tidyverse)
library(dplyr)
library(caret)
library(ggplot2)
library(corrplot)
library(janitor)
library(readxl)

#Import Dataset
df <- read_excel("E:/r_practise/customer_data.xlsx")
head(df)

#Clean Column Names
df <- df %>% clean_names()
head(df)

#Basic EDA - Structure & Summary
str(df)
summary(df)
glimpse(df)

#Check Missing Values
colSums(is.na(df))

#Convert Variables to Factors
df$region <- as.factor(df$region)
df$gender <- as.factor(df$gender)
df$contract_type <- as.factor(df$contract_type)
df$churn <- as.factor(df$churn)

#Univariate Analysis

# Age Distribution Histogram
ggplot(df, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "#FFD700", color = "#2c3e50", alpha = 0.85) +
  geom_density(aes(y = ..count.. * 5), color = "#e74c3c", size = 1, linetype = "dashed") +
  theme_minimal(base_size = 14) +
  labs(
    title = "Age Distribution of Customers",
    subtitle = "Histogram with Density Curve",
    x = "Customer Age",
    y = "Number of Customers",
    caption = "Data Source: Customer Analytics Dataset"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 18, color = "#2c3e50"),
    plot.subtitle = element_text(size = 13, face = "italic"),
    axis.title = element_text(face = "bold", color = "#34495e"),
    axis.text = element_text(color = "#2c3e50"),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  )

# Monthly Charges Histogram 
ggplot(df, aes(x = monthly_charges)) +
  geom_histogram(binwidth = 5, fill = "#2E86C1", color = "white", alpha = 0.9) +  # Corporate blue with clean white borders
  theme_minimal(base_size = 14) +
  labs(
    title = "Monthly Charges Distribution",
    subtitle = "Understanding Billing Patterns Across Customers",
    x = "Monthly Charges (in USD)",
    y = "Number of Customers",
    caption = "Internal Analytics Dashboard"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#2C3E50"),
    plot.subtitle = element_text(size = 12, face = "italic", color = "#34495E"),
    axis.title = element_text(size = 12, face = "bold", color = "#2C3E50"),
    axis.text = element_text(color = "#2C3E50"),
    panel.grid.major = element_line(color = "gray85"),
    panel.grid.minor = element_blank()
  )


#Bivariate Analysis - Categorical vs Churn
library(scales)

# Churn Rate by Region
ggplot(df, aes(x = region, fill = churn)) +
  geom_bar(position = "fill", color = "white", alpha = 0.95) +
  scale_y_continuous(labels = percent_format(), expand = c(0, 0)) +
  scale_fill_manual(
    values = c("No" = "#2ECC71", "Yes" = "#E74C3C"),  # Green = No churn, Red = Yes churn
    name = "Churn Status"
  ) +
  labs(
    title = "Churn Rate by Region",
    subtitle = "Percentage of Customers Who Have Churned vs. Stayed",
    x = "Region",
    y = "Percentage",
    caption = "Data Source: Customer Analytics Dataset"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#2C3E50"),
    plot.subtitle = element_text(size = 12, face = "italic"),
    axis.title = element_text(face = "bold", color = "#2C3E50"),
    axis.text = element_text(color = "#2C3E50"),
    legend.title = element_text(face = "bold"),
    panel.grid.major.y = element_line(color = "gray85"),
    panel.grid.minor = element_blank()
  )


# Contract Type vs Churn
ggplot(df, aes(x = contract_type, fill = churn)) +
  geom_bar(position = "fill", color = "white", alpha = 0.95) +
  scale_y_continuous(labels = percent_format(), expand = c(0, 0)) +
  scale_fill_manual(
    values = c("No" = "#2ECC71", "Yes" = "#E74C3C"),
    name = "Churn Status"
  ) +
  labs(
    title = "Churn Rate by Contract Type",
    subtitle = "Proportional Comparison of Churn by Contract Type",
    x = "Contract Type",
    y = "Percentage of Customers",
    caption = "Source: Customer Analytics Dataset"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#2C3E50"),
    plot.subtitle = element_text(size = 12, face = "italic"),
    axis.title = element_text(face = "bold", color = "#2C3E50"),
    axis.text = element_text(color = "#2C3E50"),
    legend.title = element_text(face = "bold"),
    panel.grid.major.y = element_line(color = "gray85"),
    panel.grid.minor = element_blank()
  )


# Satisfaction vs Churn
ggplot(df, aes(x = as.factor(satisfaction_score), fill = churn)) +
  geom_bar(position = "fill", color = "white", alpha = 0.95) +
  scale_y_continuous(labels = percent_format(), expand = c(0, 0)) +
  scale_fill_manual(
    values = c("No" = "#2ECC71", "Yes" = "#E74C3C"),
    name = "Churn Status"
  ) +
  labs(
    title = "Churn vs Satisfaction Score",
    subtitle = "Proportional Churn Distribution by Satisfaction Level",
    x = "Customer Satisfaction Score",
    y = "Percentage of Customers",
    caption = "Source: Customer Analytics Dataset"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#2C3E50"),
    plot.subtitle = element_text(size = 12, face = "italic"),
    axis.title = element_text(face = "bold", color = "#2C3E50"),
    axis.text = element_text(color = "#2C3E50"),
    legend.title = element_text(face = "bold"),
    panel.grid.major.y = element_line(color = "gray85"),
    panel.grid.minor = element_blank()
  )

#Correlation Between Numeric Features
num_cols <- df %>% select_if(is.numeric)
corrplot(cor(num_cols), method = "square", type = "lower")

#Predictive Modeling: Logistic Regression

#Create a train/test split
set.seed(123)
train_index <- createDataPartition(df$churn, p = 0.8, list = FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# Build logistic model
log_model <- glm(churn ~ age + monthly_charges + satisfaction_score + tenure +
                   customer_service_calls + avg_purchase_value + contract_type,
                 data = train_data, family = "binomial")

summary(log_model)

# Predict on test
pred_probs <- predict(log_model, newdata = test_data, type = "response")
pred_classes <- ifelse(pred_probs > 0.5, "Yes", "No")

# Evaluate accuracy
confusionMatrix(as.factor(pred_classes), test_data$churn)

