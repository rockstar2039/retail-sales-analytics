import pandas as pd
from sqlalchemy import create_engine

# Connect to MySQL
engine = create_engine(
    "mysql+pymysql://root:Root%402039@localhost:3306/retail_sales"
)

query = "SELECT * FROM superstore"
df = pd.read_sql(query,engine)

# Export to MySQL
df.to_sql(
    "superstore",
    con=engine,
    if_exists="replace",
    index=False
)

print("Data Imported Successfully!")


print(df.head())

print(df.shape)

print(df.columns)

print(df.dtypes)

df["Order Date"] = pd.to_datetime(
    df["Order Date"],
    dayfirst= True
)
df["Ship Date"] = pd.to_datetime(
    df["Ship Date"],
    dayfirst= True
)

print(df.dtypes)

region_sales = (
    df.groupby("Region")["Sales"]
    .sum()
    .sort_values(ascending=False)
)

print(region_sales)

region_sales = (
    df.groupby("Region", as_index= False) ["Sales"]
    .sum()
    .sort_values("Sales", ascending=False)
)
region_sales["Sales"] = region_sales["Sales"].round(2)
print(region_sales)

df["Order Date"] = pd.to_datetime(
    df["Order Date"],
    dayfirst=True
)

df["Year"] = df["Order Date"].dt.year

yearly_sales = (
    df.groupby("Year", as_index = False)["Sales"]
    .sum()
    .sort_values("Year")
)

yearly_sales["Sales"] = yearly_sales["Sales"].round(2)

print(yearly_sales)

yearly_analysis = (
    df.groupby("Year")
    .agg(
        Total_Sales=("Sales","sum"),
        Unique_Orders = ("Order ID","nunique")
    )
    .reset_index()
)

yearly_analysis["AOV"] = (
    yearly_analysis["Total_Sales"]/
    yearly_analysis["Unique_Orders"]
).round(2)


yearly_analysis["Total_Sales"] = (
    yearly_analysis["Total_Sales"].round(2)
)

print(yearly_analysis)

import matplotlib.pyplot as plt

plt.figure(figsize=(8,5))

plt.plot(
    yearly_analysis["Year"],
    yearly_analysis["Total_Sales"],
    marker="o"
)

plt.title("Yearly Sales Trend")
plt.xlabel("Year")
plt.ylabel("Total Sales")
plt.xticks(yearly_analysis["Year"])
plt.show()

plt.figure(figsize=(9,6))
plt.bar(
    region_sales["Region"],
    region_sales["Sales"]
)
plt.title("Sales by Region")
plt.xlabel("Region")
plt.ylabel("Total Sales")

plt.show()

customer_data = (
    df.groupby("Customer ID")
      .agg(
          Unique_Orders=("Order ID", "nunique"),
          Total_Sales=("Sales", "sum")
      )
      .reset_index()
)

customer_data["Total_Sales"] = customer_data["Total_Sales"].round(2)

print(customer_data.head())

def customer_segment(orders):
    if orders <=3:
        return "Low Frequency"
    elif orders <=7:
        return "Regular"
    elif orders <=12:
        return "High Frequency"
    else:
        return "Very High Frequency"

customer_data["Customer_Segment"] = (
    customer_data["Unique_Orders"].apply(customer_segment)
)

segment_analysis = (
    customer_data
    .groupby("Customer_Segment")
    .agg(
        Number_Of_Customers=("Customer ID", "count"),
        Total_Sales=("Total_Sales", "sum"),
        Avg_Sales_Per_Customer=("Total_Sales", "mean")
    )
    .reset_index()
)
segment_analysis["Total_Sales"] = (
    segment_analysis["Total_Sales"].round(2)
)

segment_analysis["Avg_Sales_Per_Customer"] = (
    segment_analysis["Avg_Sales_Per_Customer"].round(2)
)

print(segment_analysis)

plt.figure(figsize=(8,5))

plt.bar(
    segment_analysis["Customer_Segment"],
    segment_analysis["Total_Sales"]
)
plt.title("Sales by Customer Segment")
plt.xlabel('Customer Segment')
plt.ylabel("Total Sales")

plt.xticks(rotation=20)

plt.show()