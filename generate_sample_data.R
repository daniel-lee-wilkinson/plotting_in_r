# Sample Data Generator for Tufte Visualization Exercises
# This script generates a realistic sales dataset for practicing data visualization

library(tidyverse)

# Set seed for reproducibility
set.seed(42)

# Define parameters
years <- 2020:2023
regions <- c("North", "South", "East", "West")
products <- c("Product_A", "Product_B", "Product_C")

# Create base dataset
data <- expand.grid(
  year = years,
  region = regions,
  product = products,
  stringsAsFactors = FALSE
)

# Generate realistic metrics with trends and variation
data <- data %>%
  mutate(
    # Base revenue varies by product, with growth trend over years
    base_revenue = case_when(
      product == "Product_A" ~ 120000,
      product == "Product_B" ~ 90000,
      product == "Product_C" ~ 150000
    ),

    # Regional multipliers
    regional_factor = case_when(
      region == "North" ~ 1.0,
      region == "South" ~ 1.1,
      region == "East" ~ 0.95,
      region == "West" ~ 1.05
    ),

    # Year-over-year growth (different for each product)
    year_growth = case_when(
      product == "Product_A" ~ (year - 2020) * 0.08,
      product == "Product_B" ~ (year - 2020) * 0.10,
      product == "Product_C" ~ (year - 2020) * 0.07
    ),

    # Calculate revenue with some random variation
    revenue = round(base_revenue * regional_factor * (1 + year_growth) * runif(n(), 0.95, 1.05)),

    # Units sold (correlated with revenue but not perfectly)
    units_sold = round(revenue / runif(n(), 250, 300)),

    # Customer satisfaction (higher for better performing products)
    satisfaction_base = case_when(
      product == "Product_A" ~ 4.2,
      product == "Product_B" ~ 3.8,
      product == "Product_C" ~ 4.5
    ),
    customer_satisfaction = round(satisfaction_base + runif(n(), -0.2, 0.2) + (year - 2020) * 0.05, 1),
    customer_satisfaction = pmin(customer_satisfaction, 5.0),  # Cap at 5.0

    # Market share (correlated with revenue)
    market_share = round(revenue / sum(revenue) * 100 * runif(n(), 0.95, 1.05), 1)
  ) %>%
  select(year, region, product, revenue, units_sold, customer_satisfaction, market_share)

# Ensure market share is reasonable (normalize within year-region)
data <- data %>%
  group_by(year, region) %>%
  mutate(market_share = round(market_share / sum(market_share) * 60, 1)) %>%  # Assume 60% market coverage
  ungroup()

# Preview the data
print("Dataset Summary:")
print(glimpse(data))

print("\nFirst few rows:")
print(head(data, 10))

print("\nSummary statistics:")
print(summary(data))

# Save to CSV
write_csv(data, "sample_data.csv")

cat("\nDataset saved to 'sample_data.csv'\n")
cat(paste("Total rows:", nrow(data), "\n"))
cat(paste("Years covered:", min(data$year), "to", max(data$year), "\n"))
cat(paste("Regions:", paste(unique(data$region), collapse = ", "), "\n"))
cat(paste("Products:", paste(unique(data$product), collapse = ", "), "\n"))
